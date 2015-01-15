package com.redhat.shopping.demo.application.pojos.jpa;

public class ProductsTwitterData {
	 	private String productname; 
	    private String productvendor; 
	    private String productdescription; 
	    private java.math.BigDecimal buyprice; 
	    private String productline;  
	    private String textdescription; 
	    private String htmldescription;
	    
	    
		public ProductsTwitterData(Products products) {
			
			productname = products.getProductname();
			productvendor = products.getProductcode();
			productdescription = products.getProductdescription();
			buyprice = products.getBuyprice();
			productline = products.getProductline().getProductline();
			textdescription = products.getProductline().getTextdescription(); 
		    htmldescription = products.getProductline().getHtmldescription();
		}
		
		
		@Override
		public String toString() {
			return "ProductsTwitterData [productname=" + productname
					+ ", productvendor=" + productvendor
					+ ", productdescription=" + productdescription
					+ ", buyprice=" + buyprice + ", productline=" + productline
					+ ", textdescription=" + textdescription
					+ ", htmldescription=" + htmldescription + "]";
		}
		public String getProductname() {
			return productname;
		}
		public void setProductname(String productname) {
			this.productname = productname;
		}
		public String getProductvendor() {
			return productvendor;
		}
		public void setProductvendor(String productvendor) {
			this.productvendor = productvendor;
		}
		public String getProductdescription() {
			return productdescription;
		}
		public void setProductdescription(String productdescription) {
			this.productdescription = productdescription;
		}
		public java.math.BigDecimal getBuyprice() {
			return buyprice;
		}
		public void setBuyprice(java.math.BigDecimal buyprice) {
			this.buyprice = buyprice;
		}
		public String getProductline() {
			return productline;
		}
		public void setProductline(String productline) {
			this.productline = productline;
		}
		public String getTextdescription() {
			return textdescription;
		}
		public void setTextdescription(String textdescription) {
			this.textdescription = textdescription;
		}
		public String getHtmldescription() {
			return htmldescription;
		}
		public void setHtmldescription(String htmldescription) {
			this.htmldescription = htmldescription;
		} 
	    
	    
	    
}
