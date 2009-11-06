package nl.hajari.wha.web;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import nl.hajari.wha.domain.Constants;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "admin/constants", automaticallyMaintainView = true, formBackingObject = Constants.class)
@RequestMapping("/admin/constants/**")
@Controller
public class ConstantsController {
}
