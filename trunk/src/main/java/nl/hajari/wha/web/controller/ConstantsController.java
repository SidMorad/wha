package nl.hajari.wha.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import nl.hajari.wha.domain.Constants;
import nl.hajari.wha.service.ConstantsService;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "constants", automaticallyMaintainView = false, formBackingObject = Constants.class)
@RequestMapping("/constants/**")
@Controller
public class ConstantsController extends AbstractController {
	
	@Autowired
	protected ConstantsService constantsService;
	
	public void setConstantsService(ConstantsService constantsService) {
		this.constantsService = constantsService;
	}
}
