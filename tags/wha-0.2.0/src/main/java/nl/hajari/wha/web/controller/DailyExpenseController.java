package nl.hajari.wha.web.controller;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import nl.hajari.wha.domain.DailyExpense;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "dailyexpense", automaticallyMaintainView = false, formBackingObject = DailyExpense.class)
@RequestMapping("/dailyexpense/**")
@Controller
public class DailyExpenseController {
}
