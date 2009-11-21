package nl.hajari.wha.web.controller;

import nl.hajari.wha.domain.Employee;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RooWebScaffold(path = "employee", automaticallyMaintainView = false, formBackingObject = Employee.class)
@RequestMapping("/employee/**")
@Controller
public class EmployeeController {
}
