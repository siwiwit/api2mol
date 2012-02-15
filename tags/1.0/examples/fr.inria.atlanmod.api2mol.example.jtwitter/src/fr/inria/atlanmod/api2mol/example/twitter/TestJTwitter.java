/*******************************************************************************
 * Copyright (c) 2008, 2012
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 * Contributors:
 *    Javier Canovas (javier.canovas@inria.fr) 
 *******************************************************************************/

package fr.inria.atlanmod.api2mol.example.twitter;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Writer;

import org.eclipse.gmt.modisco.core.modeling.Model;

import fr.inria.atlanmod.api2mol.AbstractTest;


import winterwell.jtwitter.OAuthSignpostClient;
import winterwell.jtwitter.Twitter;

public class TestJTwitter extends AbstractTest {
	public static final String JTWITTER_OAUTH_KEY = "aWwTyu3t7G8ogZfsmOvUA";
	public static final String JTWITTER_OAUTH_SECRET = "UjM8DMvJ7KDr1LdzmDaGqIDGRPUUX6iXiP7ODNc7gq8";

	public static final String TWITTER_USER = "api2moltest";
	public static final String TWITTER_PASSWORD = "testingapi2mol";

	public static boolean USE_OAUTH = false;
	public static File accessTokenFile = new File("accessToken.txt");
	public static File accessTokenSecretFile = new File("accessTokenSecret.txt");
	
	public static String modelPath = "./model/resultJTwitter.ecore";
	public static String modelPath2 = "./model/resultJTwitter.ecore";
	public static String api2molTransformationPath = "./transformation/resultApi2mol-ATL-JTwitter.ecore";
	public static String metamodelPath = "./metamodel/resultEcore-ATL-JTwitter.ecore";

	public static void main(String[] args) {
		Twitter twitter = getTwitterAccount();
		
		Model result1 = launchInjector(api2molTransformationPath, metamodelPath, twitter, modelPath);
	}
	
	private static Twitter getTwitterAccount() {
		// Make a Twitter object
		Twitter twitter = null;
		if(USE_OAUTH) {
			OAuthSignpostClient oauthClient = null;
			if(accessTokenFile.exists() && accessTokenSecretFile.exists()) {
				String accessToken = readFile(accessTokenFile);
				String accessTokenSecret = readFile(accessTokenFile);
				oauthClient = new OAuthSignpostClient(JTWITTER_OAUTH_KEY, JTWITTER_OAUTH_SECRET, accessToken, accessTokenSecret);
			} else {
				oauthClient = new OAuthSignpostClient(JTWITTER_OAUTH_KEY, JTWITTER_OAUTH_SECRET, "oob");
				oauthClient.authorizeDesktop();
				// String v = oauthClient.askUser("Please enter the verification PIN from Twitter");
				String v = readInput("Enter Code");
				oauthClient.setAuthorizationCode(v);
				// Store the authorisation token details for future use
				String[] accessToken = oauthClient.getAccessToken();
				writeFile(accessTokenFile,accessToken[0]);
				writeFile(accessTokenSecretFile, accessToken[1]);
			}
			twitter = new Twitter(TWITTER_USER, oauthClient);
		} else {
			twitter = new Twitter(TWITTER_USER, TWITTER_PASSWORD);
		}
		
		return twitter;
//		System.out.println(twitter.getStatus("jlcanovas"));
//		
//		List<Twitter.User> following = twitter.getFriends();
//		for(Twitter.User user : following) {
//			System.out.println("Following: " + user.getName());
//		}
	}

	private static String readInput(String message) {
		String value = null;
		System.out.println(message);
		InputStreamReader isr = new InputStreamReader(System.in);
		BufferedReader br = new BufferedReader(isr);
		try {
			value = br.readLine();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return value;
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

	private static String readFile(File file) {
		StringBuilder accessTokenBuilder = new StringBuilder();
		try {
			BufferedReader input = new BufferedReader(new FileReader(file));
			String line = null;
			while (( line = input.readLine()) != null){
				accessTokenBuilder.append(line);
				accessTokenBuilder.append(System.getProperty("line.separator"));
			}
			input.close();
		} catch (IOException ex){
			ex.printStackTrace();
		}

		return accessTokenBuilder.toString();
	}
}
