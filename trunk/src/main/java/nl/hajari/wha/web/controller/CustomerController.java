package nl.hajari.wha.web.controller;

import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import nl.hajari.wha.domain.Customer;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RooWebScaffold(path = "customer", automaticallyMaintainView = false, formBackingObject = Customer.class)
@RequestMapping("/customer/**")
@Controller
public class CustomerController extends AbstractController {

	@RequestMapping(value = "/customer/report/pdf", method = RequestMethod.GET)
	public String fireReport(ModelMap modelMap) {
		JRBeanCollectionDataSource jrDataSource = new JRBeanCollectionDataSource(Customer.findAllCustomers(), false);
		modelMap.put("customerListData", jrDataSource);
		return "customerList";
	}

}
