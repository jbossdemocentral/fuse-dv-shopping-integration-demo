package com.redhat.shopping.demo.application.services;

import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;

import com.google.gdata.client.authn.oauth.OAuthHmacSha1Signer;
import com.google.gdata.client.authn.oauth.OAuthParameters;
import com.google.gdata.client.contacts.ContactsService;
import com.google.gdata.data.contacts.ContactEntry;
import com.google.gdata.data.contacts.ContactFeed;
import com.redhat.shopping.demo.application.beans.User;

public class TokenLoginService {

	@Autowired
    private Properties credentials;

    /**
     * Sets properties that contains the application's consumer key and consumer secret.
     *
     * @param credentials consumer key and consumer secret.
     */
    public void setCredentials(Properties credentials) {
        this.credentials = credentials;
    }

    
    public User getContactNames(String accessToken, String accessTokenSecret) throws Exception {
    	ContactsService loginService = new ContactsService("shopping-application"); 
        OAuthParameters params = getOAuthParams(accessToken, accessTokenSecret);
        loginService.setOAuthCredentials(params, new OAuthHmacSha1Signer());
        URL feedUrl = new URL("https://www.google.com/m8/feeds/contacts/default/full");
        ContactFeed resultFeed = loginService.getFeed(feedUrl, ContactFeed.class);
        String userEmailId = resultFeed.getId();
        String userName = resultFeed.getAuthors().get(0).getName();
        List<String> contactsInfo = new ArrayList<String>();
        for (int i = 0; i < resultFeed.getEntries().size(); i++) {
             ContactEntry entry = resultFeed.getEntries().get(i);
             contactsInfo.add(entry.getTitle().getPlainText());
        }
        User user = new User();
        user.setContacts(contactsInfo);
        user.setEmailId(userEmailId);
        user.setUserName(userName);
        return user;
    }
    
    private OAuthParameters getOAuthParams(String accessToken, String accessTokenSecret) {
        OAuthParameters params = new OAuthParameters();
        params.setOAuthConsumerKey(credentials.getProperty("consumer.key"));
        params.setOAuthConsumerSecret(credentials.getProperty("consumer.secret"));
        params.setOAuthToken(accessToken);
        params.setOAuthTokenSecret(accessTokenSecret);
        return params;
    }
    
}