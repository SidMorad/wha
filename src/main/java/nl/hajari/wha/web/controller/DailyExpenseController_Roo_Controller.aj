package nl.hajari.wha.web.controller;

import java.lang.Long;
import java.lang.String;
import javax.validation.Valid;
import nl.hajari.wha.domain.Customer;
import nl.hajari.wha.domain.DailyExpense;
import nl.hajari.wha.domain.Timesheet;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

privileged aspect DailyExpenseController_Roo_Controller {
    
    @RequestMapping(value = "/dailyexpense", method = RequestMethod.POST)
    public String DailyExpenseController.create(@Valid DailyExpense dailyExpense, BindingResult result, ModelMap modelMap) {
        if (dailyExpense == null) throw new IllegalArgumentException("A dailyExpense is required");
        if (result.hasErrors()) {
            modelMap.addAttribute("dailyExpense", dailyExpense);
            modelMap.addAttribute("customers", Customer.findAllCustomers());
            modelMap.addAttribute("timesheets", Timesheet.findAllTimesheets());
            return "dailyexpense/create";
        }
        dailyExpense.persist();
        return "redirect:/dailyexpense/" + dailyExpense.getId();
    }
    
    @RequestMapping(value = "/dailyexpense/form", method = RequestMethod.GET)
    public String DailyExpenseController.createForm(ModelMap modelMap) {
        modelMap.addAttribute("dailyExpense", new DailyExpense());
        modelMap.addAttribute("customers", Customer.findAllCustomers());
        modelMap.addAttribute("timesheets", Timesheet.findAllTimesheets());
        return "dailyexpense/create";
    }
    
    @RequestMapping(value = "/dailyexpense/{id}", method = RequestMethod.GET)
    public String DailyExpenseController.show(@PathVariable("id") Long id, ModelMap modelMap) {
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        modelMap.addAttribute("dailyExpense", DailyExpense.findDailyExpense(id));
        return "dailyexpense/show";
    }
    
    @RequestMapping(value = "/dailyexpense", method = RequestMethod.GET)
    public String DailyExpenseController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, ModelMap modelMap) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            modelMap.addAttribute("dailyexpenses", DailyExpense.findDailyExpenseEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));
            float nrOfPages = (float) DailyExpense.countDailyExpenses() / sizeNo;
            modelMap.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            modelMap.addAttribute("dailyexpenses", DailyExpense.findAllDailyExpenses());
        }
        return "dailyexpense/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT)
    public String DailyExpenseController.update(@Valid DailyExpense dailyExpense, BindingResult result, ModelMap modelMap) {
        if (dailyExpense == null) throw new IllegalArgumentException("A dailyExpense is required");
        if (result.hasErrors()) {
            modelMap.addAttribute("dailyExpense", dailyExpense);
            modelMap.addAttribute("customers", Customer.findAllCustomers());
            modelMap.addAttribute("timesheets", Timesheet.findAllTimesheets());
            return "dailyexpense/update";
        }
        dailyExpense.merge();
        return "redirect:/dailyexpense/" + dailyExpense.getId();
    }
    
    @RequestMapping(value = "/dailyexpense/{id}/form", method = RequestMethod.GET)
    public String DailyExpenseController.updateForm(@PathVariable("id") Long id, ModelMap modelMap) {
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        modelMap.addAttribute("dailyExpense", DailyExpense.findDailyExpense(id));
        modelMap.addAttribute("customers", Customer.findAllCustomers());
        modelMap.addAttribute("timesheets", Timesheet.findAllTimesheets());
        return "dailyexpense/update";
    }
    
    @RequestMapping(value = "/dailyexpense/{id}", method = RequestMethod.DELETE)
    public String DailyExpenseController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size) {
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        DailyExpense.findDailyExpense(id).remove();
        return "redirect:/dailyexpense?page=" + ((page == null) ? "1" : page.toString()) + "&size=" + ((size == null) ? "10" : size.toString());
    }
    
    @RequestMapping(value = "find/ByTimesheet/form", method = RequestMethod.GET)
    public String DailyExpenseController.findDailyExpensesByTimesheetForm(ModelMap modelMap) {
        modelMap.addAttribute("timesheets", Timesheet.findAllTimesheets());
        return "dailyexpense/findDailyExpensesByTimesheet";
    }
    
    @RequestMapping(value = "find/ByTimesheet", method = RequestMethod.GET)
    public String DailyExpenseController.findDailyExpensesByTimesheet(@RequestParam("timesheet") Timesheet timesheet, ModelMap modelMap) {
        if (timesheet == null) throw new IllegalArgumentException("A Timesheet is required.");
        modelMap.addAttribute("dailyexpenses", DailyExpense.findDailyExpensesByTimesheet(timesheet).getResultList());
        return "dailyexpense/list";
    }
    
}
