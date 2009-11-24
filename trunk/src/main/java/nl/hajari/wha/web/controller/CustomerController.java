package nl.hajari.wha.web.controller;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import nl.hajari.wha.domain.Customer;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "customer", automaticallyMaintainView = false, formBackingObject = Customer.class)
@RequestMapping("/customer/**")
@Controller
public class CustomerController {
}
