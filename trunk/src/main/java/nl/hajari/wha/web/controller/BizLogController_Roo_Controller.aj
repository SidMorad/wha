package nl.hajari.wha.web.controller;

import java.lang.Long;
import java.lang.String;
import javax.validation.Valid;
import nl.hajari.wha.domain.BizLog;
import nl.hajari.wha.domain.Employee;
import nl.hajari.wha.domain.Timesheet;
import nl.hajari.wha.domain.User;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

privileged aspect BizLogController_Roo_Controller {
    
    @RequestMapping(value = "/bizlog", method = RequestMethod.POST)
    public String BizLogController.create(@Valid BizLog bizLog, BindingResult result, ModelMap modelMap) {
        if (bizLog == null) throw new IllegalArgumentException("A bizLog is required");
        if (result.hasErrors()) {
            modelMap.addAttribute("bizLog", bizLog);
            modelMap.addAttribute("employees", Employee.findAllEmployees());
            modelMap.addAttribute("timesheets", Timesheet.findAllTimesheets());
            modelMap.addAttribute("users", User.findAllUsers());
            return "bizlog/create";
        }
        bizLog.persist();
        return "redirect:/bizlog/" + bizLog.getId();
    }
    
    @RequestMapping(value = "/bizlog/form", method = RequestMethod.GET)
    public String BizLogController.createForm(ModelMap modelMap) {
        modelMap.addAttribute("bizLog", new BizLog());
        modelMap.addAttribute("employees", Employee.findAllEmployees());
        modelMap.addAttribute("timesheets", Timesheet.findAllTimesheets());
        modelMap.addAttribute("users", User.findAllUsers());
        return "bizlog/create";
    }
    
    @RequestMapping(value = "/bizlog/{id}", method = RequestMethod.GET)
    public String BizLogController.show(@PathVariable("id") Long id, ModelMap modelMap) {
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        modelMap.addAttribute("bizLog", BizLog.findBizLog(id));
        return "bizlog/show";
    }
    
    @RequestMapping(value = "/bizlog", method = RequestMethod.GET)
    public String BizLogController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, ModelMap modelMap) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            modelMap.addAttribute("bizlogs", BizLog.findBizLogEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));
            float nrOfPages = (float) BizLog.countBizLogs() / sizeNo;
            modelMap.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            modelMap.addAttribute("bizlogs", BizLog.findAllBizLogs());
        }
        return "bizlog/list";
    }
    
    @RequestMapping(value = "/bizlog/{id}", method = RequestMethod.DELETE)
    public String BizLogController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size) {
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        BizLog.findBizLog(id).remove();
        return "redirect:/bizlog?page=" + ((page == null) ? "1" : page.toString()) + "&size=" + ((size == null) ? "10" : size.toString());
    }
    
    @RequestMapping(value = "find/ByTimesheet/form", method = RequestMethod.GET)
    public String BizLogController.findBizLogsByTimesheetForm(ModelMap modelMap) {
        modelMap.addAttribute("timesheets", Timesheet.findAllTimesheets());
        return "bizlog/findBizLogsByTimesheet";
    }
    
    @RequestMapping(value = "find/ByTimesheet", method = RequestMethod.GET)
    public String BizLogController.findBizLogsByTimesheet(@RequestParam("timesheet") Timesheet timesheet, ModelMap modelMap) {
        if (timesheet == null) throw new IllegalArgumentException("A Timesheet is required.");
        modelMap.addAttribute("bizlogs", BizLog.findBizLogsByTimesheet(timesheet).getResultList());
        return "bizlog/list";
    }
    
}
