package nl.hajari.wha.web.controller;

import nl.hajari.wha.domain.DailyTimesheet;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RooWebScaffold(path = "dailytimesheet", automaticallyMaintainView = false, formBackingObject = DailyTimesheet.class, exposeFinders = false)
@RequestMapping("/dailytimesheet/**")
@Controller
public class DailyTimesheetController extends AbstractController {

}
