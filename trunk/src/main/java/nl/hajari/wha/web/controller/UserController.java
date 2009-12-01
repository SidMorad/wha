package nl.hajari.wha.web.controller;

import java.util.List;

import javax.validation.ConstraintViolation;
import javax.validation.Validation;

import nl.hajari.wha.domain.Role;
import nl.hajari.wha.domain.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RooWebScaffold(path = "admin/user", automaticallyMaintainView = false, formBackingObject = User.class)
@RequestMapping("/admin/user/**")
@Controller
public class UserController implements UserDetailsService {

	@Autowired
	PasswordEncoder passwordEncoder;
	
	@Override
	public UserDetails loadUserByUsername(String username)
			throws UsernameNotFoundException, DataAccessException {
		List<User> users = User.findUsersByUsernameEquals(username).getResultList();
		if (users.size() == 1) {
			return users.get(0);
		}
		throw new UsernameNotFoundException("Username: [ " + username+ " ] not found!");
	}

    @RequestMapping(value = "/admin/user", method = RequestMethod.POST)    
    public String create(@ModelAttribute("user") User user, BindingResult result, ModelMap modelMap) {    
        if (user == null) throw new IllegalArgumentException("A user is required");        
        for (ConstraintViolation<User> constraint : Validation.buildDefaultValidatorFactory().getValidator().validate(user)) {        
            result.rejectValue(constraint.getPropertyPath().toString(), "user.error." + constraint.getPropertyPath(), constraint.getMessage());            
        }
        
        List<User> users = User.findUsersByUsernameEquals(user.getUsername()).getResultList();
        if (users.size() > 0) {
        	result.rejectValue("username", "error.usernameExists");
        }

        if (!user.getPassword().endsWith(user.getConfirmPassword())) {
        	result.rejectValue("password", "error.passwordIsNotSame");
        }
        
        if (result.hasErrors()) {        
            modelMap.addAllAttributes(result.getAllErrors());            
            modelMap.addAttribute("user", user);            
            modelMap.addAttribute("roles", Role.findAllRoles());            
            return "admin/user/create";            
        }
        user.setPassword(passwordEncoder.encodePassword(user.getPassword(), null));
        user.persist();        
        return "redirect:/admin/user/" + user.getId();        
    }    
	
    @RequestMapping(method = RequestMethod.PUT)    
    public String update(@ModelAttribute("user") User user, BindingResult result, ModelMap modelMap) {    
        if (user == null) throw new IllegalArgumentException("A user is required");        
        User oldUser = findUserByUsername(user.getUsername()); 
        user.setPassword(oldUser.getPassword());
        for (ConstraintViolation<User> constraint : Validation.buildDefaultValidatorFactory().getValidator().validate(user)) {        
            result.rejectValue(constraint.getPropertyPath().toString(), "user.error." + constraint.getPropertyPath(), constraint.getMessage());            
        }
        if (result.hasErrors()) {        
            modelMap.addAllAttributes(result.getAllErrors());            
            modelMap.addAttribute("user", user);            
            modelMap.addAttribute("roles", Role.findAllRoles());            
            return "admin/user/update";            
        }        
        user.merge();        
        return "redirect:/admin/user/" + user.getId();        
    }

	public User findUserByUsername(String username) {
		User user = (User) User.findUsersByUsernameEquals(username).getSingleResult();
		return user;
	}    
    
	@RequestMapping(value = "/admin/user/change_password/{id}/form", method = RequestMethod.GET)
	public String createChangePasswordForm(@PathVariable("id") Long id, ModelMap modelMap) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        modelMap.addAttribute("user", User.findUser(id));
		return "admin/user/changePassword";
	}
	
	@RequestMapping(value = "/admin/user/change_password", method = RequestMethod.POST)
	public String changePassword(@ModelAttribute("user") User user, BindingResult result, ModelMap modelMap) {
        if (user == null) throw new IllegalArgumentException("A user is required");        
        User oldUser = findUserByUsername(user.getUsername()); 
 
        if (!user.getPassword().endsWith(user.getConfirmPassword())) {
        	result.rejectValue("password", "error.passwordIsNotSame");
        }
     
        if (result.hasErrors()) {     
        	modelMap.addAttribute("user", user);
            return "admin/user/changePassword";            
        }
        oldUser.setPassword(passwordEncoder.encodePassword(user.getPassword(), null));
        oldUser.merge();        
        return "redirect:/admin/user/" + user.getId();        
    }
	
}
