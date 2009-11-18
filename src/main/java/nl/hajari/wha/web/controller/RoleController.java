package nl.hajari.wha.web.controller;

import java.util.List;

import nl.hajari.wha.domain.Role;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RooWebScaffold(path = "role", automaticallyMaintainView = true, formBackingObject = Role.class)
@RequestMapping("/role/**")
@Controller
public class RoleController {
	
	public Role getRole(String name) {
		List<Role> roles = Role.findRolesByNameEquals(name).getResultList();
		if (roles.size() == 1) {
			return roles.get(0);
		}
		return null;
	}
}
