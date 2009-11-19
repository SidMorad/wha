package nl.hajari.wha.web.controller;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import nl.hajari.wha.domain.Timesheet;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "timesheet", automaticallyMaintainView = true, formBackingObject = Timesheet.class, update = false, delete = false)
@RequestMapping("/timesheet/**")
@Controller
public class TimesheetController {
}
