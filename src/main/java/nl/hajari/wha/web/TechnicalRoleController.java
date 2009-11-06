package nl.hajari.wha.web;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import nl.hajari.wha.domain.TechnicalRole;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "technicalrole", automaticallyMaintainView = true, formBackingObject = TechnicalRole.class)
@RequestMapping("/technicalrole/**")
@Controller
public class TechnicalRoleController {
}
