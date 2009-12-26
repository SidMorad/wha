package nl.hajari.wha.web.controller;

import nl.hajari.wha.domain.Timesheet;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RooWebScaffold(path = "timesheet", automaticallyMaintainView = false, formBackingObject = Timesheet.class, update = false, delete = false)
@RequestMapping("/timesheet/**")
@Controller
public class TimesheetController {
}
