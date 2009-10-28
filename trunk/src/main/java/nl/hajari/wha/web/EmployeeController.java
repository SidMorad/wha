package nl.hajari.wha.web;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import nl.hajari.wha.domain.Employee;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "employee", automaticallyMaintainView = true, formBackingObject = Employee.class)
@RequestMapping("/employee/**")
@Controller
public class EmployeeController {
}
