package nl.hajari.wha.web.controller;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import nl.hajari.wha.domain.Constants;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "constants", automaticallyMaintainView = false, formBackingObject = Constants.class)
@RequestMapping("/constants/**")
@Controller
public class ConstantsController extends AbstractController {
}
