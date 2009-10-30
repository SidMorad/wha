package nl.hajari.wha.web;

import java.util.List;

import nl.hajari.wha.domain.EmpMonth;
import nl.hajari.wha.domain.Employee;
import nl.hajari.wha.domain.MonthStatus;
import nl.hajari.wha.utils.ComboUtil;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

@RequestMapping("/admin/empmonth/**")
@Controller
@SessionAttributes("empmonth")
public class EmpMonthAdminController {

	@RequestMapping
	public String get(ModelMap modelMap) {
		ComboUtil comboUtil = new ComboUtil();
		EmpMonth empMonth = new EmpMonth();
		empMonth.setNumber(comboUtil.getCurrentNumber());
		modelMap.put("empmonth", empMonth);
		modelMap.put("months", comboUtil.getMonthCombo());
		modelMap.put("employees", Employee.findAllEmployees());
		return "admin/empmonth/create";
	}

	@RequestMapping(method = RequestMethod.POST)
	public String post(@ModelAttribute("empmonth") EmpMonth empMonth,
			ModelMap modelMap) {

		if (empMonth.getId() == null) {
			List empmounths = EmpMonth.findEmpMonthsByEmployeeAndNumberEquals(
					empMonth.getEmployee(), empMonth.getNumber())
					.getResultList();
			if (empmounths.size() > 0) {
				modelMap.put("errors","This month exist for this employee , please select another month or employee.");
				modelMap.put("months", new ComboUtil().getMonthCombo());
				modelMap.put("employees", Employee.findAllEmployees());
				return "admin/empmonth/create";
			}
			empMonth.setMonthStatus(MonthStatus.NEW);
			empMonth.persist();
		} else {
//			empMonth.setMonthStatus(MonthStatus.CURRENT);
//			empMonth.merge();
		}

		return "admin/empmonth/show";
	}
}
