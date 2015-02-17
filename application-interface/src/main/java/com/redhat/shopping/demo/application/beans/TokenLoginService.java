package com.redhat.shopping.demo.application.beans;

import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import com.google.gdata.client.authn.oauth.OAuthHmacSha1Signer;
import com.google.gdata.client.authn.oauth.OAuthParameters;
import com.google.gdata.client.contacts.ContactsService;
import com.google.gdata.data.contacts.ContactEntry;
import com.google.gdata.data.contacts.ContactFeed;

public class TokenLoginService  {


    private String consumerKey;
    
    private String consumerSecret;

    /**
     * Obtains a list of names of a user's public and private calendars from the Google
     * Calendar API.
     * 
     * @param accessToken OAuth access token.
     * @param accessTokenSecret OAuth access token secret.
     * @return list of names of a user's public and private calendars.
     */
    public List<String> getContactNames(String accessToken, String accessTokenSecret) throws Exception {
    	ContactsService loginService = new ContactsService("shopping-application"); 
        OAuthParameters params = getOAuthParams(accessToken, accessTokenSecret);
        loginService.setOAuthCredentials(params, new OAuthHmacSha1Signer());
        URL feedUrl = new URL("https://www.google.com/m8/feeds/contacts/default/full");
        ContactFeed resultFeed = loginService.getFeed(feedUrl, ContactFeed.class);

        List<String> result = new ArrayList<String>();
        for (int i = 0; i < resultFeed.getEntries().size(); i++) {
             ContactEntry entry = resultFeed.getEntries().get(i);
            result.add(entry.getTitle().getPlainText());
        }
        return result;
    }
    
    private OAuthParameters getOAuthParams(String accessToken, String accessTokenSecret) {
        OAuthParameters params = new OAuthParameters();
        params.setOAuthConsumerKey("anonymous");
        params.setOAuthConsumerSecret("anonymous");
        params.setOAuthToken(accessToken);
        params.setOAuthTokenSecret(accessTokenSecret);
        return params;
    }

	public String getConsumerKey() {
		return consumerKey;
	}

	public void setConsumerKey(String consumerKey) {
		this.consumerKey = consumerKey;
	}

	public String getConsumerSecret() {
		return consumerSecret;
	}

	public void setConsumerSecret(String consumerSecret) {
		this.consumerSecret = consumerSecret;
	}
}