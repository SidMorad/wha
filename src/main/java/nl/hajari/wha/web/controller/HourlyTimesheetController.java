package nl.hajari.wha.web.controller;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import nl.hajari.wha.domain.HourlyTimesheet;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "hourlytimesheet", automaticallyMaintainView = true, formBackingObject = HourlyTimesheet.class)
@RequestMapping("/hourlytimesheet/**")
@Controller
public class HourlyTimesheetController {
}
