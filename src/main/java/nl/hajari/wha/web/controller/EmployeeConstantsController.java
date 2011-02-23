package nl.hajari.wha.web.controller;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import nl.hajari.wha.domain.EmployeeConstants;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "admin/emp_cons", automaticallyMaintainView = false, formBackingObject = EmployeeConstants.class)
@RequestMapping("/admin/emp_cons/**")
@Controller
public class EmployeeConstantsController {
}
