package winterwell.jtwitter;

import java.io.BufferedReader;
import java.io.Closeable;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Method;
import java.net.ConnectException;
import java.net.HttpURLConnection;
import java.net.SocketException;
import java.net.SocketTimeoutException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import lgpl.haustein.Base64Encoder;

import org.json.JSONException;
import org.json.JSONObject;

/**
 * A simple http client that uses the built in URLConnection class.
 * <p>
 * Provides Twitter-focused error-handling, generating the right
 * TwitterException.
 * Also has a retry-on-error mode which can help smooth out Twitter's
 * sometimes intermittent service. See {@link #setRetryOnError(boolean)}.
 * 
 * @author Daniel Winterstein
 *
 */
public class URLConnectionHttpClient implements Twitter.IHttpClient {

	protected String name;
	private final String password;
	/**
	 * true if we are in the middle of a retry attempt. false normally
	 */
	private boolean retryingFlag;
	/**
	 * If true, will wait 1 second and make a 2nd request when presented with a server error.
	 */
	private boolean retryOnError;

	public URLConnectionHttpClient(String name, String password) {
		this.name = name;
		this.password = password;
		assert (name!=null && password != null) || (name==null && password==null);
	}

	public URLConnectionHttpClient() {
		this(null,null);
	}

	public boolean canAuthenticate() {
		return name != null && password != null;
	}
	
	
	
	private static final int dfltTimeOutMilliSecs = 10 * 1000;
	
	protected int timeout = dfltTimeOutMilliSecs;
	
	@Override
	public void setTimeout(int millisecs) {
		this.timeout = millisecs;
	}

	public String getPage(String uri, Map<String, String> vars, boolean authenticate) throws TwitterException {
		assert uri != null;
		if (vars != null && vars.size() != 0) {
			uri += "?";
			for (Entry<String, String> e : vars.entrySet()) {
				if (e.getValue() == null)
					continue;
				uri += encode(e.getKey()) + "=" + encode(e.getValue()) + "&";
			}
		}
		try {
			// Setup a connection
			final HttpURLConnection connection = (HttpURLConnection) new URL(uri).openConnection();			
			// Authenticate
			if (authenticate) {
				setAuthentication(connection, name, password);
			}
			// To keep the search API happy - which wants either a referrer or a user agent
			connection.setRequestProperty("User-Agent", "JTwitter/"+Twitter.version);
			connection.setDoInput(true);
			connection.setReadTimeout(timeout);
			// Open a connection
			processError(connection);
			final InputStream inStream = connection.getInputStream();
			// Read in the web page
			String page = toString(inStream);
			// Done
			return page;
		} catch (SocketTimeoutException e) {
			throw new TwitterException.Timeout(uri);
		} catch (IOException e) {
			throw new TwitterException(e);
		} catch (TwitterException.E50X e) {
			if ( ! retryOnError || retryingFlag) throw e;								
			try {
				retryingFlag = true;
				Thread.sleep(1000);
				return getPage(uri, vars, authenticate);
			} catch (InterruptedException ex) {
				// ignore the interruption & just throw the original error
				throw e;
			} finally {
				retryingFlag = false;
			}
		}
	}
		
		
	/**
	 * Throw an exception if the connection failed
	 * @param connection
	 */
	void processError(HttpURLConnection connection) {
		try {
			int code = connection.getResponseCode();
			if (code==200) return;
			URL url = connection.getURL();
			// any explanation?
			String error = connection.getResponseMessage();
			Map<String, List<String>> headers = connection.getHeaderFields();
			List<String> errorMessage = headers.get(null);
			if (errorMessage!=null && ! errorMessage.isEmpty()) {
				error += "\n"+errorMessage.get(0);
			}
			InputStream es = connection.getErrorStream();
			String errorPage = null; 
			if (es!=null) {
				errorPage = read(es);
				error += "\n"+errorPage;
			}			
			// which error?
			if (code==401) {
				throw new TwitterException.E401(error+"\n"+url+" ("+(name==null?"anonymous":name)+")");
			}
			if (code==403) {
				// is this a "too old" exception?
				if (errorPage != null && errorPage.contains("too old")) {
					throw new TwitterException.BadParameter(errorPage+"\n"+url);
				}
				throw new TwitterException.E403(error+"\n"+url
						+" ("+getName()+")");
			}
			if (code==404) {				
				throw new TwitterException.E404(error+"\n"+url);
			}
			if (code >= 500 && code<600) {
				throw new TwitterException.E50X(error+"\n"+url);
			}
			boolean rateLimitExceeded = error.contains("Rate limit exceeded");
			if (rateLimitExceeded) {
				throw new TwitterException.RateLimit(error);
			}
			// Rate limiter can sometimes cause a 400 Bad Request			
			if (code==400) {
				String json = getPage("http://twitter.com/account/rate_limit_status.json",
						null, password!=null);
				try {
					JSONObject obj = new JSONObject(json);
					int hits = obj.getInt("remaining_hits");
					if (hits<1) throw new TwitterException.RateLimit(error);
				} catch (JSONException e) {
					// oh well
				}				
			}
			
			// just report it as a vanilla exception
			throw new TwitterException(code + " " + error+" "+url);
			
		} catch (SocketTimeoutException e) {
			URL url = connection.getURL();
			throw new TwitterException.Timeout(timeout+"milli-secs for "+url);
		} catch(ConnectException e) {
			// probably also a time out
			URL url = connection.getURL();
			throw new TwitterException.Timeout(url.toString());
		} catch (SocketException e) {
			// treat as a server error - because it probably is
			// (yes, it could also be an error at your end)
			throw new TwitterException.E50X(e.toString());
		} catch (IOException e) {
			throw new TwitterException(e);
		}
	}	

	private String read(InputStream stream) throws IOException {
		try {
			BufferedReader reader = new BufferedReader(new InputStreamReader(stream));
			final int bufSize = 8192; // this is the default BufferredReader
			// buffer size
			StringBuilder sb = new StringBuilder(bufSize);
			char[] cbuf = new char[bufSize];
			while (true) {
				int chars = reader.read(cbuf);
				if (chars == -1)
					break;
				sb.append(cbuf, 0, chars);
			}
			return sb.toString();
		} finally {
			stream.close();
		}
	}

	String getName() {
		return name;
	}

	private String getErrorStream(HttpURLConnection connection) {
		try {
			return toString(connection.getErrorStream());
		} catch (NullPointerException e) {
			return null;
		}
	}
	
	@Override
	public String toString() {
		return getClass().getName()+"[name="+name+", password="+(password==null? "null" : "XXX")+"]";
	}

	/**
	 * Set a header for basic authentication login.
	 */
	protected void setAuthentication(URLConnection connection, String name,
			String password) {
		assert name != null && password != null : "Authentication requested but no login details are set!";
		String token = name + ":" + password;
		String encoding = Base64Encoder.encode(token);
		connection.setRequestProperty("Authorization", "Basic " + encoding);
	}
	
	public String post(String uri, Map<String, String> vars, boolean authenticate) throws TwitterException {
		HttpURLConnection connection = null;
		try {
			connection = (HttpURLConnection) new URL(uri).openConnection();
			connection.setRequestMethod("POST");
			connection.setDoOutput(true);
			if (authenticate) {
				setAuthentication(connection, name, password);
			}
			connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			connection.setReadTimeout(timeout);			
			String payload = post2_getPayload(vars);
			connection.setRequestProperty("Content-Length", "" + payload.length());
			OutputStream os = connection.getOutputStream();
			os.write(payload.getBytes());
			close(os);			
			// Get the response
			processError(connection);
			String response = toString(connection.getInputStream());
			return response;
		} catch (IOException e) {
			throw new TwitterException(e);
		} catch (TwitterException.E50X e) {
			if ( ! retryOnError || retryingFlag) throw e;
			try {
				Thread.sleep(1000);		
				retryingFlag = true;				
				return post(uri, vars, authenticate);
			} catch (InterruptedException ex) {
				// ignore the interruption & just throw the original error
				throw e;
			} finally {
				retryingFlag = false;
			}
		}
	}

	protected String post2_getPayload(Map<String, String> vars) {
		if (vars == null || vars.isEmpty()) return "";
		StringBuilder encodedData = new StringBuilder();
	
		for (String key : vars.keySet()) {
			String val = encode(vars.get(key));
			encodedData.append(encode(key));
			encodedData.append('=');
			encodedData.append(val);
			encodedData.append('&');
		}
		encodedData.deleteCharAt(encodedData.length()-1);
		return encodedData.toString();
	}
	
	
	/**
	 * False by default. Setting this to true switches on a robustness
	 * workaround: when presented with a 50X server error, the
	 * system will wait 1 second and make a second attempt. 
	 */
	public void setRetryOnError(boolean retryOnError) {
		this.retryOnError = retryOnError;
	}
	


	
	private static String encode(Object x) {
		return URLEncoder.encode(String.valueOf(x));
	}

	/**
	 * Use a bufferred reader (preferably UTF-8) to extract the contents of
	 * the given stream. A convenience method for {@link #toString(Reader)}.
	 */
	protected static String toString(InputStream inputStream) {
		InputStreamReader reader;
		try {
			reader = new InputStreamReader(inputStream, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			reader = new InputStreamReader(inputStream);
		}
		return toString(reader);
	}
	
	/**
	 * Use a buffered reader to extract the contents of the given reader.
	 * 
	 * @param reader
	 * @return The contents of this reader.
	 */
	private static String toString(Reader reader) throws RuntimeException {
		try {
			// Buffer if not already buffered
			reader = reader instanceof BufferedReader ? (BufferedReader) reader : new BufferedReader(reader);
			StringBuilder output = new StringBuilder();
			while (true) {
				int c = reader.read();
				if (c == -1)
					break;
				output.append((char) c);
			}
			return output.toString();
		} catch (IOException ex) {
			throw new RuntimeException(ex);
		} finally {
			close(reader);
		}
	}

	/**
	 * Close a reader/writer/stream, ignoring any exceptions that result. Also
	 * flushes if there is a flush() method.
	 */
	protected static void close(Closeable input) {
		if (input == null)
			return;
		// Flush (annoying that this is not part of Closeable)
		try {
			Method m = input.getClass().getMethod("flush");
			m.invoke(input);
		} catch (Exception e) {
			// Ignore
		}
		// Close
		try {
			input.close();
		} catch (IOException e) {
			// Ignore
		}
	}

}
