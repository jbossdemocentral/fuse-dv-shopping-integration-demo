package com.redhat.shopping.demo.application.beans;

import java.util.List;

public class User {
private List<String> contacts;
private String emailId;
private String userName;
public List<String> getContacts() {
	return contacts;
}
public void setContacts(List<String> contacts) {
	this.contacts = contacts;
}
public String getEmailId() {
	return emailId;
}
public void setEmailId(String emailId) {
	this.emailId = emailId;
}
public String getUserName() {
	return userName;
}
public void setUserName(String userName) {
	this.userName = userName;
}
	
}
