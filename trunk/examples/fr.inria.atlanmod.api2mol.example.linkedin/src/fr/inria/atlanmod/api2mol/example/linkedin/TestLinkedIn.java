/*******************************************************************************
 * Copyright (c) 2008, 2012
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 * Contributors:
 *    Javier Canovas (javier.canovas@inria.fr) 
 *    Fabian Somda 
 *******************************************************************************/

package fr.inria.atlanmod.api2mol.example.linkedin;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Writer;
import java.util.Calendar;


import com.google.code.linkedinapi.client.LinkedInApiClient;
import com.google.code.linkedinapi.client.LinkedInApiClientFactory;
import com.google.code.linkedinapi.client.oauth.LinkedInAccessToken;
import com.google.code.linkedinapi.client.oauth.LinkedInOAuthService;
import com.google.code.linkedinapi.client.oauth.LinkedInOAuthServiceFactory;
import com.google.code.linkedinapi.client.oauth.LinkedInRequestToken;
import com.google.code.linkedinapi.schema.Person;

import fr.inria.atlanmod.api2mol.AbstractTest;

public class TestLinkedIn extends AbstractTest {

	public static final String JLINKEDIN_OAUTH_KEY = "a_Ul_C3b6MQ5qU5_71M9bnoluER4FqbC-XqdWWp-xd6xxUtTBBA2PcLRKLOlC7Fj";
	public static final String JLINKEDIN_OAUTH_SECRET = "pxes9dkPLr_S6dQdeVTHEeNt_NjZyie0TVIA_yqiP72Za5Cr8wCEa7FwZstfYku3";
	
	public static File accessTokenFile = new File("accessToken.txt");
	public static File accessTokenSecretFile = new File("accessTokenSecret.txt");

	// Output model
	public static String modelPath = "./model/Flavien-LinkedIn.xmi";
	
	// Input mapping
	public static String api2molTransformationPath = "./transformation/LinkedIn-API2MoL.ecore";

	// Input metamodel
	public static String metamodelPath = "./metamodel/LinkedIn.ecore";

	/**
	 * @param args
	 */
	public static void main(String[] args) {
        try {
            final String consumerKeyValue = JLINKEDIN_OAUTH_KEY;
            final String consumerSecretValue = JLINKEDIN_OAUTH_SECRET;
            String accessToken;
            String accessTokenSecret;
			if(accessTokenFile.exists() && accessTokenSecretFile.exists()) {
				accessToken = readFile(accessTokenFile);
				accessTokenSecret = readFile(accessTokenSecretFile);
			} else {
	            final LinkedInOAuthService oauthService = LinkedInOAuthServiceFactory.getInstance().createLinkedInOAuthService(consumerKeyValue, consumerSecretValue);
	            
	            System.out.println("Fetching request token from LinkedIn...");
	            
	            LinkedInRequestToken requestToken = oauthService.getOAuthRequestToken();
	            Calendar c = Calendar.getInstance();
	            c.add(Calendar.MONTH, 1);
	            requestToken.setExpirationTime(c.getTime());
			    String authUrl = requestToken.getAuthorizationUrl();
			
			    System.out.println("Request token: " + requestToken.getToken());
			    System.out.println("Token secret: " + requestToken.getTokenSecret());
			    System.out.println("Expiration time: " + requestToken.getExpirationTime());
			
			    System.out.println("Now visit:\n" + authUrl
			            + "\n... and grant this app authorization");
			    System.out.println("Enter the PIN code and hit ENTER when you're done:");
	
			    BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
			    String pin = br.readLine();
			
			    System.out.println("Fetching access token from LinkedIn...");
			    
			    LinkedInAccessToken accessTokenObject = oauthService.getOAuthAccessToken(requestToken, pin);
			
			    accessToken = accessTokenObject.getToken();
			    accessTokenSecret = accessTokenObject.getTokenSecret();
			    System.out.println("Access token: " + accessToken);
			    System.out.println("Token secret: " + accessTokenSecret);

			    writeFile(accessTokenFile, accessToken);
				writeFile(accessTokenSecretFile, accessTokenSecret);
			}
            final LinkedInApiClientFactory factory = LinkedInApiClientFactory.newInstance(consumerKeyValue, consumerSecretValue);
            final LinkedInApiClient client = factory.createLinkedInApiClient(accessToken, accessTokenSecret);
            System.out.println("Fetching profile for current user.");
            Person profile = client.getProfileForCurrentUser();
            System.out.println(profile.getFirstName());
            System.out.println(profile.getConnections());

            Object object = profile;
            object = client.getConnectionsForCurrentUser();
            launchInjector(api2molTransformationPath, metamodelPath, object, modelPath);
        } catch (Exception e) {
            e.printStackTrace();
        }
	}

	private static String readFile(File file) {
		StringBuilder accessTokenBuilder = new StringBuilder();
		try {
			BufferedReader input = new BufferedReader(new FileReader(file));
			String line = null;
			while (( line = input.readLine()) != null){
				accessTokenBuilder.append(line);
				//accessTokenBuilder.append(System.getProperty("line.separator"));
			}
			input.close();
		} catch (IOException ex){
			ex.printStackTrace();
		}

		return accessTokenBuilder.toString();
	}

	private static void writeFile(File file, String content) {
		try {
			Writer output = new BufferedWriter(new FileWriter(file));
			output.write(content.toString());
			output.close();
		} catch (IOException ex){
			ex.printStackTrace();
		}
	}
}
