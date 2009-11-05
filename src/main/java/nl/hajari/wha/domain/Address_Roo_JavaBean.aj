package nl.hajari.wha.domain;

import java.lang.String;

privileged aspect Address_Roo_JavaBean {
    
    public String Address.getAddress() {    
        return this.address;        
    }    
    
    public void Address.setAddress(String address) {    
        this.address = address;        
    }    
    
    public String Address.getCity() {    
        return this.city;        
    }    
    
    public void Address.setCity(String city) {    
        this.city = city;        
    }    
    
    public String Address.getProvince() {    
        return this.province;        
    }    
    
    public void Address.setProvince(String province) {    
        this.province = province;        
    }    
    
    public String Address.getCountry() {    
        return this.country;        
    }    
    
    public void Address.setCountry(String country) {    
        this.country = country;        
    }    
    
    public String Address.getPostcode() {    
        return this.postcode;        
    }    
    
    public void Address.setPostcode(String postcode) {    
        this.postcode = postcode;        
    }    
    
}
