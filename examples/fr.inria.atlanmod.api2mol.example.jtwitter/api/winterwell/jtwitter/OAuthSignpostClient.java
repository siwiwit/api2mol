package winterwell.jtwitter;

import java.awt.Desktop;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.StringBufferInputStream;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import java.util.Properties;
import java.util.Map.Entry;

import javax.swing.JOptionPane;

import oauth.signpost.AbstractOAuthConsumer;
import oauth.signpost.OAuthConsumer;
import oauth.signpost.OAuthProvider;
import oauth.signpost.basic.DefaultOAuthConsumer;
import oauth.signpost.basic.DefaultOAuthProvider;
import oauth.signpost.basic.HttpURLConnectionRequestAdapter;
import oauth.signpost.exception.OAuthCommunicationException;
import oauth.signpost.exception.OAuthException;
import oauth.signpost.http.HttpRequest;

import org.json.JSONException;
import org.json.JSONObject;
import org.scribe.http.Request;
import org.scribe.http.Response;
import org.scribe.http.Request.Verb;
import org.scribe.oauth.Scribe;
import org.scribe.oauth.Token;

import winterwell.jtwitter.Twitter.IHttpClient;

/**
 * OAuth based login using Signpost (http://code.google.com/p/oauth-signpost/).
 * This is the "official" JTwitter OAuth support. 
 *  
 * <p> 
 * Example Usage (desktop based):
 * <pre><code>
	OAuthSignpostClient client = new OAuthSignpostClient(JTWITTER_OAUTH_KEY, JTWITTER_OAUTH_SECRET, "oob");
	Twitter jtwit = new Twitter("yourtwittername", client);
	// open the authorisation page in the user's browser
	client.authorizeDesktop();
	// get the pin
	String v = client.askUser("Please enter the verification PIN from Twitter");
	client.setAuthorizationCode(v);
	// Optional: store the authorisation token details
	Object accessToken = client.getAccessToken();
	// use the API!
	jtwit.setStatus("Messing about in Java");
 	</code></pre>
 	
 	<p>
 	If you can handle callbacks, then this can be streamlined a little. 
 	Replace "oob" with your callback url. Direct the user to client.authorizeUrl().
 	Twitter will then call your callback with the request token and verifier
 	(authorisation code).
 <p>
  There are alternative OAuth libraries you can use:
   @see OAuthHttpClient
   @see OAuthScribeClient
 * @author Daniel
 */
public class OAuthSignpostClient extends URLConnectionHttpClient implements IHttpClient {

	@Override
	protected void setAuthentication(URLConnection connection, String name, String password) 
	{
		try {
			// sign the request
	        consumer.sign(connection);
		} catch (OAuthException e) {
			throw new TwitterException(e);
		}
	}
	
	@Override
	public String post(String uri, Map<String, String> vars,
			boolean authenticate) throws TwitterException {
		HttpURLConnection connection = null;
		try {
			connection = (HttpURLConnection) new URL(uri).openConnection();
			connection.setRequestMethod("POST");
			connection.setDoOutput(true);
			connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			connection.setReadTimeout(timeout);			
			final String payload = post2_getPayload(vars);
			if (authenticate) { 
				// needed for OAuthConsumer.collectBodyParameters() not to get upset
				HttpURLConnectionRequestAdapter wrapped = new HttpURLConnectionRequestAdapter(connection) {
					@Override
					public InputStream getMessagePayload() throws IOException {
						return new StringBufferInputStream(payload);
					}
				};
				consumer.sign(wrapped);
			}
			// add the payload
			OutputStream os = connection.getOutputStream();
			os.write(payload.getBytes());
			close(os);
			// Get the response
			processError(connection);
			String response = toString(connection.getInputStream());
			return response;
			
		} catch (IOException e) {
			throw new TwitterException(e);
		} catch (OAuthException e) {
			throw new TwitterException(e);
		}
	}
	
	private String consumerSecret;
	private String consumerKey;
	private String callbackUrl;
	private OAuthConsumer consumer;
	private DefaultOAuthProvider provider;
	private String accessToken;
	private String accessTokenSecret;

	/**
	 * 
	 * @param consumerKey
	 * @param consumerSecret
	 * @param callbackUrl Servlet that will get the verifier sent to it, 
	 * or "oob" for out-of-band (user copies and pastes the pin to you)
	 */
	public OAuthSignpostClient(String consumerKey, String consumerSecret, String callbackUrl) {
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
	public OAuthSignpostClient(String consumerKey, String consumerSecret, 
			String accessToken, String accessTokenSecret) 
	{
		this.consumerKey = consumerKey;
		this.consumerSecret = consumerSecret;
		this.accessToken = accessToken;
		this.accessTokenSecret = accessTokenSecret;
		init();		
	}
	
	@Override
	String getName() {
		return name==null? "?user" : name;
	}
	
	/**
	 * Unlike the base class {@link URLConnectionHttpClient},
	 * this does not set name by default. But you can set it for nicer
	 * error messages.
	 * @param name
	 */
	public void setName(String name) {
		this.name = name;
	}
	
	private void init() {
		// The default consumer can't do post requests! 
		// TODO override AbstractAuthConsumer.collectBodyParameters() which would be more efficient 
		consumer = new AbstractOAuthConsumer(consumerKey, consumerSecret) {
			@Override
			protected HttpRequest wrap(final Object request) {
				if (request instanceof HttpRequest) return (HttpRequest) request;
				return new HttpURLConnectionRequestAdapter((HttpURLConnection) request);
			}			
		};
		if (accessToken!=null) {
			consumer.setTokenWithSecret(accessToken, accessTokenSecret);
		}
        provider = new DefaultOAuthProvider(
                "http://twitter.com/oauth/request_token",
                "http://twitter.com/oauth/access_token",
                "http://twitter.com/oauth/authorize");
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
			String url = provider.retrieveRequestToken(consumer, callbackUrl);
			return new URI(url);
		} catch (Exception e) {
			throw new TwitterException(e);
		}		
	}
	

	/**
	 * Set the authorisation code (aka the verifier).
	 * This is only relevant when using out-of-band instead of a callback-url.
	 * @param verifier a pin code which Twitter gives the user
	 * @throws RuntimeException Scribe throws an exception if the verifier is invalid
	 */
	public void setAuthorizationCode(String verifier) throws TwitterException {
		try {
			provider.retrieveAccessToken(consumer, verifier);
			accessToken = consumer.getToken();
			accessTokenSecret = consumer.getTokenSecret();
		} catch (Exception e) {
			throw new TwitterException(e);
		}
	}
	
	@Override
	public boolean canAuthenticate() {
		return consumer.getToken() != null;
	}

	@SuppressWarnings("deprecation")
	private static String encode(Object x) {
		return URLEncoder.encode(String.valueOf(x));
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

	public String[] getAccessToken() {
		return new String[]{accessToken, accessTokenSecret};
	}
	
}
