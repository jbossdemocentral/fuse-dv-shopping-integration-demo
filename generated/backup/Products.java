package com.redhat.shopping.demo.application.pojos.jpa;

import javax.xml.bind.annotation.XmlRootElement;


/**
 *
 * <p>Title: Products</p>
 *
 * <p>Description: Domain Object describing a Products entity</p>
 *
 */

@XmlRootElement
public class Products{
    private String productcode;
    private String productname; 
    private String productscale; 
    private String productvendor; 
    private String productdescription; 
    private Short quantityinstock; 
    private java.math.BigDecimal buyprice; 
    private java.math.BigDecimal msrp; 
    private Productlines productline;  
    private String productline_;
    
    /**
    * Default constructor
    */
    public Products() {
    }

	/**
	* All field constructor 
	*/
    public Products(
       String productcode,
       String productname,
       String productline,
       String productscale,
       String productvendor,
       String productdescription,
       Short quantityinstock,
       java.math.BigDecimal buyprice,
       java.math.BigDecimal msrp) {
	 this(
       productcode,
       productname,
       productline,
       productscale,
       productvendor,
       productdescription,
       quantityinstock,
       buyprice,
       msrp
	 ,true);
	}
    
	public Products(
       String productcode,
       String productname,
       String productline,
       String productscale,
       String productvendor,
       String productdescription,
       Short quantityinstock,
       java.math.BigDecimal buyprice,
       java.math.BigDecimal msrp	
    , boolean setRelationship) {
       //primary keys
       setProductcode (productcode);
       //attributes
       setProductname (productname);
       setProductscale (productscale);
       setProductvendor (productvendor);
       setProductdescription (productdescription);
       setQuantityinstock (quantityinstock);
       setBuyprice (buyprice);
       setMsrp (msrp);
       //parents
       if (setRelationship) this.productline = new Productlines();
       if (setRelationship) this.productline.setProductline(productline); 
	   setProductline_ (productline);
    }

	public Products flat() {
	   return new Products(
          getProductcode(),
          getProductname(),
          getProductline_(),
          getProductscale(),
          getProductvendor(),
          getProductdescription(),
          getQuantityinstock(),
          getBuyprice(),
          getMsrp()
       , false
	   );
	}

    public String getProductcode() {
        return productcode;
    }
	
    public void setProductcode (String productcode) {
        this.productcode =  productcode;
    }
    

    public String getProductname() {
        return productname;
    }
	
    public void setProductname (String productname) {
        this.productname =  productname;
    }
	

    public String getProductscale() {
        return productscale;
    }
	
    public void setProductscale (String productscale) {
        this.productscale =  productscale;
    }
	

    public String getProductvendor() {
        return productvendor;
    }
	
    public void setProductvendor (String productvendor) {
        this.productvendor =  productvendor;
    }
	

    public String getProductdescription() {
        return productdescription;
    }
	
    public void setProductdescription (String productdescription) {
        this.productdescription =  productdescription;
    }
	

    public Short getQuantityinstock() {
        return quantityinstock;
    }
	
    public void setQuantityinstock (Short quantityinstock) {
        this.quantityinstock =  quantityinstock;
    }
	

    public java.math.BigDecimal getBuyprice() {
        return buyprice;
    }
	
    public void setBuyprice (java.math.BigDecimal buyprice) {
        this.buyprice =  buyprice;
    }
	

    public java.math.BigDecimal getMsrp() {
        return msrp;
    }
	
    public void setMsrp (java.math.BigDecimal msrp) {
        this.msrp =  msrp;
    }
	

    public Productlines getProductline () {
    	return productline;
    }
	
    public void setProductline (Productlines productline) {
    	this.productline = productline;
    }

    public String getProductline_() {
        return productline_;
    }
	
    public void setProductline_ (String productline) {
        this.productline_ =  productline;
    }
   

}
