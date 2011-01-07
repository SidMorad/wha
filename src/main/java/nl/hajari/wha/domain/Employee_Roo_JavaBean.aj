package nl.hajari.wha.domain;

import java.lang.Float;
import java.lang.Integer;
import java.lang.String;
import java.util.Date;
import java.util.Set;
import nl.hajari.wha.domain.TechRole;
import nl.hajari.wha.domain.User;

privileged aspect Employee_Roo_JavaBean {
    
    public String Employee.getFirstName() {
        return this.firstName;
    }
    
    public void Employee.setFirstName(String firstName) {
        this.firstName = firstName;
    }
    
    public String Employee.getLastName() {
        return this.lastName;
    }
    
    public void Employee.setLastName(String lastName) {
        this.lastName = lastName;
    }
    
    public String Employee.getEmpId() {
        return this.empId;
    }
    
    public void Employee.setEmpId(String empId) {
        this.empId = empId;
    }
    
    public Float Employee.getHourlyWage() {
        return this.hourlyWage;
    }
    
    public void Employee.setHourlyWage(Float hourlyWage) {
        this.hourlyWage = hourlyWage;
    }
    
    public User Employee.getUser() {
        return this.user;
    }
    
    public void Employee.setUser(User user) {
        this.user = user;
    }
    
    public Set<TechRole> Employee.getTechRoles() {
        return this.techRoles;
    }
    
    public void Employee.setTechRoles(Set<TechRole> techRoles) {
        this.techRoles = techRoles;
    }
    
    public String Employee.getPrivateAddress() {
        return this.privateAddress;
    }
    
    public void Employee.setPrivateAddress(String privateAddress) {
        this.privateAddress = privateAddress;
    }
    
    public Integer Employee.getPostcode() {
        return this.postcode;
    }
    
    public void Employee.setPostcode(Integer postcode) {
        this.postcode = postcode;
    }
    
    public String Employee.getPlace() {
        return this.place;
    }
    
    public void Employee.setPlace(String place) {
        this.place = place;
    }
    
    public String Employee.getPrivatePhone() {
        return this.privatePhone;
    }
    
    public void Employee.setPrivatePhone(String privatePhone) {
        this.privatePhone = privatePhone;
    }
    
    public String Employee.getWorkPhone() {
        return this.workPhone;
    }
    
    public void Employee.setWorkPhone(String workPhone) {
        this.workPhone = workPhone;
    }
    
    public String Employee.getMobile() {
        return this.mobile;
    }
    
    public void Employee.setMobile(String mobile) {
        this.mobile = mobile;
    }
    
    public Date Employee.getBirthday() {
        return this.birthday;
    }
    
    public void Employee.setBirthday(Date birthday) {
        this.birthday = birthday;
    }
    
    public Date Employee.getStartDate() {
        return this.startDate;
    }
    
    public void Employee.setStartDate(Date startDate) {
        this.startDate = startDate;
    }
    
    public String Employee.getOrganization() {
        return this.organization;
    }
    
    public void Employee.setOrganization(String organization) {
        this.organization = organization;
    }
    
    public String Employee.getManagementName() {
        return this.managementName;
    }
    
    public void Employee.setManagementName(String managementName) {
        this.managementName = managementName;
    }
    
}
