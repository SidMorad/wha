package nl.hajari.wha.web.controller;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import nl.hajari.wha.domain.Project;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "project", automaticallyMaintainView = false, formBackingObject = Project.class)
@RequestMapping("/project/**")
@Controller
public class ProjectController {
}
