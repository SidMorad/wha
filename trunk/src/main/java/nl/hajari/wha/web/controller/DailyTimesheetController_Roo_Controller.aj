package nl.hajari.wha.web.controller;

import java.lang.Long;
import java.lang.String;
import javax.validation.Valid;
import nl.hajari.wha.domain.DailyTimesheet;
import nl.hajari.wha.domain.Project;
import nl.hajari.wha.domain.Timesheet;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

privileged aspect DailyTimesheetController_Roo_Controller {
    
    @RequestMapping(value = "/dailytimesheet", method = RequestMethod.POST)
    public String DailyTimesheetController.create(@Valid DailyTimesheet dailyTimesheet, BindingResult result, ModelMap modelMap) {
        if (dailyTimesheet == null) throw new IllegalArgumentException("A dailyTimesheet is required");
        if (result.hasErrors()) {
            modelMap.addAttribute("dailyTimesheet", dailyTimesheet);
            modelMap.addAttribute("projects", Project.findAllProjects());
            modelMap.addAttribute("timesheets", Timesheet.findAllTimesheets());
            return "dailytimesheet/create";
        }
        dailyTimesheet.persist();
        return "redirect:/dailytimesheet/" + dailyTimesheet.getId();
    }
    
    @RequestMapping(value = "/dailytimesheet/form", method = RequestMethod.GET)
    public String DailyTimesheetController.createForm(ModelMap modelMap) {
        modelMap.addAttribute("dailyTimesheet", new DailyTimesheet());
        modelMap.addAttribute("projects", Project.findAllProjects());
        modelMap.addAttribute("timesheets", Timesheet.findAllTimesheets());
        return "dailytimesheet/create";
    }
    
    @RequestMapping(value = "/dailytimesheet/{id}", method = RequestMethod.GET)
    public String DailyTimesheetController.show(@PathVariable("id") Long id, ModelMap modelMap) {
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        modelMap.addAttribute("dailyTimesheet", DailyTimesheet.findDailyTimesheet(id));
        return "dailytimesheet/show";
    }
    
    @RequestMapping(value = "/dailytimesheet", method = RequestMethod.GET)
    public String DailyTimesheetController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, ModelMap modelMap) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            modelMap.addAttribute("dailytimesheets", DailyTimesheet.findDailyTimesheetEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));
            float nrOfPages = (float) DailyTimesheet.countDailyTimesheets() / sizeNo;
            modelMap.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            modelMap.addAttribute("dailytimesheets", DailyTimesheet.findAllDailyTimesheets());
        }
        return "dailytimesheet/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT)
    public String DailyTimesheetController.update(@Valid DailyTimesheet dailyTimesheet, BindingResult result, ModelMap modelMap) {
        if (dailyTimesheet == null) throw new IllegalArgumentException("A dailyTimesheet is required");
        if (result.hasErrors()) {
            modelMap.addAttribute("dailyTimesheet", dailyTimesheet);
            modelMap.addAttribute("projects", Project.findAllProjects());
            modelMap.addAttribute("timesheets", Timesheet.findAllTimesheets());
            return "dailytimesheet/update";
        }
        dailyTimesheet.merge();
        return "redirect:/dailytimesheet/" + dailyTimesheet.getId();
    }
    
    @RequestMapping(value = "/dailytimesheet/{id}/form", method = RequestMethod.GET)
    public String DailyTimesheetController.updateForm(@PathVariable("id") Long id, ModelMap modelMap) {
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        modelMap.addAttribute("dailyTimesheet", DailyTimesheet.findDailyTimesheet(id));
        modelMap.addAttribute("projects", Project.findAllProjects());
        modelMap.addAttribute("timesheets", Timesheet.findAllTimesheets());
        return "dailytimesheet/update";
    }
    
    @RequestMapping(value = "/dailytimesheet/{id}", method = RequestMethod.DELETE)
    public String DailyTimesheetController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size) {
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        DailyTimesheet.findDailyTimesheet(id).remove();
        return "redirect:/dailytimesheet?page=" + ((page == null) ? "1" : page.toString()) + "&size=" + ((size == null) ? "10" : size.toString());
    }
    
}
