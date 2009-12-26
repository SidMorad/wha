package nl.hajari.wha.web.controller;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import nl.hajari.wha.domain.DailyTravel;

import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "dailytravel", automaticallyMaintainView = false, formBackingObject = DailyTravel.class)
@RequestMapping("/dailytravel/**")
@Controller
public class DailyTravelController {

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		binder.registerCustomEditor(java.util.Date.class,
				new org.springframework.beans.propertyeditors.CustomDateEditor(
				new java.text.SimpleDateFormat("d/MM/yy"), true));
	}
}
