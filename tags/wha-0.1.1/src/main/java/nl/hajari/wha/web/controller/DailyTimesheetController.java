package nl.hajari.wha.web.controller;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import nl.hajari.wha.domain.DailyTimesheet;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "dailytimesheet", automaticallyMaintainView = false, formBackingObject = DailyTimesheet.class)
@RequestMapping("/dailytimesheet/**")
@Controller
public class DailyTimesheetController {
}
