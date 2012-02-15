package winterwell.jtwitter;

import java.awt.Desktop;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URLEncoder;
import java.util.Map;
import java.util.Properties;
import java.util.Map.Entry;

import javax.swing.JOptionPane;

import org.json.JSONException;
import org.json.JSONObject;
import org.scribe.eq.YahooEqualizer;
import org.scribe.http.Request;
import org.scribe.http.Response;
import org.scribe.http.Request.Verb;
import org.scribe.oauth.Scribe;
import org.scribe.oauth.Token;

import winterwell.jtwitter.Twitter.IHttpClient;

/**
 * OAuth based login using Scribe (http://github.com/fernandezpablo85/scribe).
 * <i>You need version 0.6.6 of Scribe (or above)!</i>
 * <p> 
 * Example Usage (desktop based):
 * <pre><code>
	OAuthScribeClient client = new OAuthScribeClient(JTWITTER_OAUTH_KEY, JTWITTER_OAUTH_SECRET, "oob");
	Twitter jtwit = new Twitter("yourtwittername", client);
	// open the authorisation page in the user's browser
	client.authorizeDesktop();
	// get the pin
	String v = client.askUser("Please enter the verification PIN from Twitter");
	client.setAuthorizationCode(v);	
	// use the API!
	jtwit.setStatus("Messing about in Java");
 	</code></pre>
 * @author daniel
 * 
 * <p>
  There are alternative OAuth libraries you can use:
 * @see OAuthSignpostClient This is the "officially supported" JTwitter OAuth client. 
 * @see OAuthHttpClient
 */
public class OAuthScribeClient implements IHttpClient {
	
	private boolean retryOnError;

	/**
	 * False by default. Setting this to true switches on a robustness
	 * workaround: when presented with a 50X server error, the
	 * system will wait 1 second and make a second attempt. 
	 * This is NOT thread safe.
	 */
	public void setRetryOnError(boolean retryOnError) {
		this.retryOnError = retryOnError;
	}
	
	private String consumerSecret;
	private String consumerKey;
	private String callbackUrl;
	private Scribe scribe;
	private Token accessToken;
	private Token requestToken;
	private boolean retryingFlag;
	// TODO use this!
	private int timeout;

	/**
	 * 
	 * @param consumerKey
	 * @param consumerSecret
	 * @param callbackUrl Servlet that will get the verifier sent to it, 
	 * or "oob" for out-of-band (user copies and pastes the pin to you)
	 */
	public OAuthScribeClient(String consumerKey, String consumerSecret, String callbackUrl) {
		assert consumerKey != null && consumerSecret != null && callbackUrl != null;
		this.consumerKey = consumerKey;
		this.consumerSecret = consumerSecret;
		this.callbackUrl = callbackUrl;
		init();
	}
	
	/**
	 * Use this if you already have an accessToken for the user.
	 * You can then go straight to using the API without having to authorise again.
	 * @param consumerKey
	 * @param consumerSecret
	 * @param accessToken
	 */
	public OAuthScribeClient(String consumerKey, String consumerSecret, Token accessToken) {
		this.consumerKey = consumerKey;
		this.consumerSecret = consumerSecret;
		this.accessToken = accessToken;
		init();		
	}
	
	private void init() {
		Properties props = new Properties();
		// hard coded for efficiency & why not?
//			props.load(YahooEqualizer.class.getResourceAsStream("twitter.properties"));
		props.put("request.token.url", "http://twitter.com/oauth/request_token");
		props.put("access.token.verb","POST"); 
		props.put("request.token.verb","POST"); 
		props.put("access.token.url","http://twitter.com/oauth/access_token");			
		props.put("consumer.key", consumerKey);
		props.put("consumer.secret", consumerSecret);
		if (callbackUrl!=null) props.put("callback.url", callbackUrl);
		scribe = new Scribe(props);	
	}
	
	/**
	 * Opens a popup dialog asking the user to enter the verification code.
	 * (you would then call {@link #setAuthorizationCode(String)}).
	 * This is only relevant when using out-of-band instead of a callback-url.
	 * This is a convenience method -- you will probably want to build your own
	 * UI around this.
	 * 
	 * @param question e.g. "Please enter the authorisation code from Twitter"
	 * @return
	 */
	public static String askUser(String question) {
		return JOptionPane.showInputDialog(question);
	}
	
	/**
	 * Redirect the user's browser to Twitter's authorise page.
	 * You will need to collect the verifier pin - either from the callback servlet,
	 * or from the user (out-of-band).
	 * @see #authorizeUrl()
	 */
	public void authorizeDesktop() {
		URI uri = authorizeUrl();
		try {
			Desktop d = Desktop.getDesktop();
			d.browse(uri);
		} catch (IOException e) {
			throw new TwitterException(e);
		}		
	}
	
	/**
	 * @return url to direct the user to for authorisation.
	 */
	public URI authorizeUrl() {
		try {
			requestToken = scribe.getRequestToken();
			String url = "https://api.twitter.com/oauth/authorize?oauth_token="
							+requestToken.getToken()
//							+"&oauth_callback="+callbackUrl
							;
			return new URI(url);
		} catch (URISyntaxException e) {
			throw new TwitterException(e);
		}		
	}
	
	/**
	 * @return the request token, if one has been created via {@link #authorizeUrl()}.
	 */
	public Token getRequestToken() {
		return requestToken;
	}
	
	/**
	 * @return the access token, if set.
	 */
	public Token getAccessToken() {
		return accessToken;
	}

	/**
	 * Set the authorisation code (aka the verifier).
	 * This is only relevant when using out-of-band instead of a callback-url.
	 * @param verifier a pin code which Twitter gives the user
	 * @throws RuntimeException Scribe throws an exception if the verifier is invalid
	 */
	public void setAuthorizationCode(String verifier) throws RuntimeException {		
		accessToken = scribe.getAccessToken(requestToken, verifier);
	}
	
	@Override
	public boolean canAuthenticate() {
		return accessToken!=null;
	}

	@SuppressWarnings("deprecation")
	private static String encode(Object x) {
		return URLEncoder.encode(String.valueOf(x));
	}
	
	@Override
	public String getPage(String uri, Map<String, String> vars,
			boolean authenticate) throws TwitterException 
	{
		try {
			assert canAuthenticate();
			if (vars != null && vars.size() != 0) {
				uri += "?";
				for (Entry<String, String> e : vars.entrySet()) {
					if (e.getValue() == null)
						continue;
					uri += encode(e.getKey()) + "=" + encode(e.getValue()) + "&";
				}
			}
			Request request = new Request(Verb.GET, uri);
//			request.setTimeout(timeout);
			scribe.signRequest(request, accessToken);
			Response response = request.send();
			processError(response);
			return response.getBody();

		// retry on error?
		} catch (TwitterException.E50X e) {
			if ( ! retryOnError || retryingFlag) throw e;								
			try {
				retryingFlag = true;
				Thread.sleep(1000);
				return getPage(uri, vars, authenticate);
			} catch (InterruptedException ex) {
				throw new TwitterException(ex);
			} finally {
				retryingFlag = false;
			}
		}		
	}
	
	/**
	 * Throw an exception if the connection failed
	 * @param response
	 */
	void processError(Response response) {
		int code = response.getCode();
		if (code==200) return;
		Map<String, String> headers = response.getHeaders();
		String error = headers.get(null);
		if (code==401) {
			throw new TwitterException.E401(error);
		}
		if (code==403) {
			throw new TwitterException.E403(error);
		}
		if (code==404) {
			throw new TwitterException.E404(error);
		}
		if (code >= 500 && code<600) {
			throw new TwitterException.E50X(error);
		}
		boolean rateLimitExceeded = error.contains("Rate limit exceeded");
		if (rateLimitExceeded) {
			throw new TwitterException.RateLimit(error);
		}
		// Rate limiter can sometimes cause a 400 Bad Request			
		if (code==400) {
			String json = getPage("http://twitter.com/account/rate_limit_status.json",
					null, true);
			try {
				JSONObject obj = new JSONObject(json);
				int hits = obj.getInt("remaining_hits");
				if (hits<1) throw new TwitterException.RateLimit(error);
			} catch (JSONException e) {
				// oh well
			}				
		}		
		// just report it as a vanilla exception
		throw new TwitterException(code + " " + error);
	}	

	/**
	 * This consumer key (and secret) allows you to get up and running fast.
	 * However you are strongly advised to register your own app at http://dev.twitter.com
	 * Then use your own key and secret. This will be less confusing for users, and it
	 * protects you incase the JTwitter key gets changed. 
	 */
	public static final String JTWITTER_OAUTH_KEY = "Cz8ZLgitPR2jrQVaD6ncw";

	/**
	 * For use with {@link #JTWITTER_OAUTH_KEY}
	 */
	public static final String JTWITTER_OAUTH_SECRET = "9FFYaWJSvQ6Yi5tctN30eN6DnXWmdw0QgJMl7V6KGI";
	
	@Override
	public String post(String uri, Map<String, String> vars,
			boolean authenticate) throws TwitterException 
	{
		try {
			
			assert canAuthenticate();		
			Request request = new Request(Verb.POST, uri);
			if (vars != null && vars.size() != 0) {
				for (Entry<String, String> e : vars.entrySet()) {
					if (e.getValue() == null)
						continue;
					request.addBodyParameter(e.getKey(), e.getValue());
				}
			}
//			request.setTimeout(timeout);
			scribe.signRequest(request, accessToken);
			Response response = request.send();
			processError(response);
			return response.getBody();
			
		// retry on error?
		} catch (TwitterException.E50X e) {
			if ( ! retryOnError || retryingFlag) throw e;								
			try {
				retryingFlag = true;
				Thread.sleep(1000);
				return getPage(uri, vars, authenticate);
			} catch (InterruptedException ex) {
				throw new TwitterException(ex);
			} finally {
				retryingFlag = false;
			}
		}
	}

	/**
	 * This does not do anything at present!
	 */
	@Deprecated
	@Override
	public void setTimeout(int millisecs) {
		this.timeout = millisecs;
	}
}
