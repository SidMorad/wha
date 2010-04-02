package nl.hajari.wha.web.controller;

import javax.validation.ConstraintViolation;
import javax.validation.Validation;

import nl.hajari.wha.domain.Role;
import nl.hajari.wha.domain.User;
import nl.hajari.wha.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
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
public class UserController extends AbstractController {

	@Autowired
	private UserService userService;

	@RequestMapping(value = "/admin/user", method = RequestMethod.POST)
	public String create(@ModelAttribute("user") User user, BindingResult result, ModelMap modelMap) {
		if (user == null)
			throw new IllegalArgumentException("A user is required");
		for (ConstraintViolation<User> constraint : Validation.buildDefaultValidatorFactory().getValidator().validate(
				user)) {
			result.rejectValue(constraint.getPropertyPath().toString(), "user.error." + constraint.getPropertyPath(),
					constraint.getMessage());
		}

		User existingUser = userService.load(user.getUsername());
		if (null != existingUser) {
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
		userService.save(user);
		return "redirect:/admin/user/" + user.getId();
	}

	@RequestMapping(method = RequestMethod.PUT)
	public String update(@ModelAttribute("user") User user, BindingResult result, ModelMap modelMap) {
		if (user == null)
			throw new IllegalArgumentException("A user is required");
		User oldUser = userService.load(user.getUsername());
		user.setPassword(oldUser.getPassword());
		for (ConstraintViolation<User> constraint : Validation.buildDefaultValidatorFactory().getValidator().validate(
				user)) {
			result.rejectValue(constraint.getPropertyPath().toString(), "user.error." + constraint.getPropertyPath(),
					constraint.getMessage());
		}
		if (result.hasErrors()) {
			modelMap.addAllAttributes(result.getAllErrors());
			modelMap.addAttribute("user", user);
			modelMap.addAttribute("roles", Role.findAllRoles());
			return "admin/user/update";
		}
		userService.update(user);
		return "redirect:/admin/user/" + user.getId();
	}

	@RequestMapping(value = "/admin/user/change_password/{id}/form", method = RequestMethod.GET)
	public String createChangePasswordForm(@PathVariable("id") Long id, ModelMap modelMap) {
		if (id == null)
			throw new IllegalArgumentException("An Identifier is required");
		modelMap.addAttribute("user", User.findUser(id));
		return "admin/user/changePassword";
	}

	@RequestMapping(value = "/admin/user/change_password", method = RequestMethod.POST)
	public String changePassword(@ModelAttribute("user") User user, BindingResult result, ModelMap modelMap) {
		if (user == null)
			throw new IllegalArgumentException("A user is required");

		if (!user.getPassword().endsWith(user.getConfirmPassword())) {
			result.rejectValue("password", "error.passwordIsNotSame");
		}

		if (result.hasErrors()) {
			modelMap.addAttribute("user", user);
			return "admin/user/changePassword";
		}

		userService.setPassword(user.getUsername(), user.getPassword());

		return "redirect:/admin/user/" + user.getId();
	}

	@RequestMapping(value = "/admin/user/onlineUsers")
	public String listOnlineUsers() {
		return "admin/user/onlineUsers";
	}
	
}
