package nl.hajari.wha.web;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import nl.hajari.wha.domain.Role;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "role", automaticallyMaintainView = true, formBackingObject = Role.class)
@RequestMapping("/role/**")
@Controller
public class RoleController {
}
