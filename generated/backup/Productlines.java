package com.redhat.shopping.demo.application.pojos.jpa;

import java.util.HashSet;
import java.util.Set;

import javax.xml.bind.annotation.XmlRootElement;




@XmlRootElement
public class Productlines {
    private String productline;
    private String textdescription; 
    private String htmldescription; 
    private String image; 
    private Set <Products> productsProductlinesViaProductline = new HashSet<Products>(); 

    /**
    * Default constructor
    */
    public Productlines() {
    }

	/**
	* All field constructor 
	*/
    public Productlines(
       String productline,
       String textdescription,
       String htmldescription,
       String image) {
	 this(
       productline,
       textdescription,
       htmldescription,
       image
	 ,true);
	}
    
	public Productlines(
       String productline,
       String textdescription,
       String htmldescription,
       String image	
    , boolean setRelationship) {
       //primary keys
       setProductline (productline);
       //attributes
       setTextdescription (textdescription);
       setHtmldescription (htmldescription);
       setImage (image);
       //parents
    }

	public Productlines flat() {
	   return new Productlines(
          getProductline(),
          getTextdescription(),
          getHtmldescription(),
          getImage()
       , false
	   );
	}

    public String getProductline() {
        return productline;
    }
	
    public void setProductline (String productline) {
        this.productline =  productline;
    }
    

    public String getTextdescription() {
        return textdescription;
    }
	
    public void setTextdescription (String textdescription) {
        this.textdescription =  textdescription;
    }
	

    public String getHtmldescription() {
        return htmldescription;
    }
	
    public void setHtmldescription (String htmldescription) {
        this.htmldescription =  htmldescription;
    }
	

    public String getImage() {
        return image;
    }
	
    public void setImage (String image) {
        this.image =  image;
    }
	

    public Set<Products> getProductsProductlinesViaProductline() {
        if (productsProductlinesViaProductline == null){
            productsProductlinesViaProductline = new HashSet<Products>();
        }
        return productsProductlinesViaProductline;
    }

    public void setProductsProductlinesViaProductline (Set<Products> productsProductlinesViaProductline) {
        this.productsProductlinesViaProductline = productsProductlinesViaProductline;
    }	
    
    public void addProductsProductlinesViaProductline (Products element) {
    	    getProductsProductlinesViaProductline().add(element);
    }
}
