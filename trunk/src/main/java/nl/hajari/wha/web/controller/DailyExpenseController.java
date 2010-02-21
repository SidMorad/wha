package nl.hajari.wha.web.controller;

import nl.hajari.wha.domain.DailyExpense;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RooWebScaffold(path = "dailyexpense", automaticallyMaintainView = false, formBackingObject = DailyExpense.class)
@RequestMapping("/dailyexpense/**")
@Controller
public class DailyExpenseController extends AbstractController {
}
