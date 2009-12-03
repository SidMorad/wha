package nl.hajari.wha.web.controller;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import nl.hajari.wha.domain.DailyTravel;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "dailytravel", automaticallyMaintainView = true, formBackingObject = DailyTravel.class)
@RequestMapping("/dailytravel/**")
@Controller
public class DailyTravelController {
}
