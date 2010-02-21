package nl.hajari.wha.web.controller;

import nl.hajari.wha.domain.DailyTravel;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RooWebScaffold(path = "dailytravel", automaticallyMaintainView = false, formBackingObject = DailyTravel.class)
@RequestMapping("/dailytravel/**")
@Controller
public class DailyTravelController extends AbstractController {

}
