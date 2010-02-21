package nl.hajari.wha.web.controller;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import nl.hajari.wha.domain.TechRole;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "techrole", automaticallyMaintainView = false, formBackingObject = TechRole.class)
@RequestMapping("/techrole/**")
@Controller
public class TechRoleController extends AbstractController {
}
