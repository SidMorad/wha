package nl.hajari.wha.web.controller;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import nl.hajari.wha.domain.BizLog;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

@RooWebScaffold(path = "bizlog", automaticallyMaintainView = false, formBackingObject = BizLog.class, update = false)
@RequestMapping("/bizlog/**")
@Controller
public class BizLogController {
}
