package nl.hajari.wha.web;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import nl.hajari.wha.domain.EmpMonth;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "empmonth", automaticallyMaintainView = true, formBackingObject = EmpMonth.class)
@RequestMapping("/empmonth/**")
@Controller
public class EmpMonthController {
}
