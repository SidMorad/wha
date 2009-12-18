package nl.hajari.wha.web.controller;

import java.lang.Long;
import java.lang.String;
import javax.validation.Valid;
import nl.hajari.wha.domain.Customer;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

privileged aspect CustomerController_Roo_Controller {
    
    @RequestMapping(value = "/customer", method = RequestMethod.POST)    
    public String CustomerController.create(@Valid Customer customer, BindingResult result, ModelMap modelMap) {    
        if (customer == null) throw new IllegalArgumentException("A customer is required");        
        if (result.hasErrors()) {        
            return "customer/create";            
        }        
        customer.persist();        
        return "redirect:/customer/" + customer.getId();        
    }    
    
    @RequestMapping(value = "/customer/form", method = RequestMethod.GET)    
    public String CustomerController.createForm(ModelMap modelMap) {    
        modelMap.addAttribute("customer", new Customer());        
        return "customer/create";        
    }    
    
    @RequestMapping(value = "/customer/{id}", method = RequestMethod.GET)    
    public String CustomerController.show(@PathVariable("id") Long id, ModelMap modelMap) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        modelMap.addAttribute("customer", Customer.findCustomer(id));        
        return "customer/show";        
    }    
    
    @RequestMapping(value = "/customer", method = RequestMethod.GET)    
    public String CustomerController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, ModelMap modelMap) {    
        if (page != null || size != null) {        
            int sizeNo = size == null ? 10 : size.intValue();            
            modelMap.addAttribute("customers", Customer.findCustomerEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));            
            float nrOfPages = (float) Customer.countCustomers() / sizeNo;            
            modelMap.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));            
        } else {        
            modelMap.addAttribute("customers", Customer.findAllCustomers());            
        }        
        return "customer/list";        
    }    
    
    @RequestMapping(method = RequestMethod.PUT)    
    public String CustomerController.update(@Valid Customer customer, BindingResult result, ModelMap modelMap) {    
        if (customer == null) throw new IllegalArgumentException("A customer is required");        
        if (result.hasErrors()) {        
            return "customer/update";            
        }        
        customer.merge();        
        return "redirect:/customer/" + customer.getId();        
    }    
    
    @RequestMapping(value = "/customer/{id}/form", method = RequestMethod.GET)    
    public String CustomerController.updateForm(@PathVariable("id") Long id, ModelMap modelMap) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        modelMap.addAttribute("customer", Customer.findCustomer(id));        
        return "customer/update";        
    }    
    
    @RequestMapping(value = "/customer/{id}", method = RequestMethod.DELETE)    
    public String CustomerController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        Customer.findCustomer(id).remove();        
        return "redirect:/customer?page=" + ((page == null) ? "1" : page.toString()) + "&size=" + ((size == null) ? "10" : size.toString());        
    }    
    
    @RequestMapping(value = "find/ByNameEquals/form", method = RequestMethod.GET)    
    public String CustomerController.findCustomersByNameEqualsForm(ModelMap modelMap) {    
        return "customer/findCustomersByNameEquals";        
    }    
    
    @RequestMapping(value = "find/ByNameEquals", method = RequestMethod.GET)    
    public String CustomerController.findCustomersByNameEquals(@RequestParam("name") String name, ModelMap modelMap) {    
        if (name == null || name.length() == 0) throw new IllegalArgumentException("A Name is required.");        
        modelMap.addAttribute("customers", Customer.findCustomersByNameEquals(name).getResultList());        
        return "customer/list";        
    }    
    
}
