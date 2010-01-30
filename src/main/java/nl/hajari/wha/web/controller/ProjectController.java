package nl.hajari.wha.web.controller;

import java.util.List;

import nl.hajari.wha.domain.Project;
import nl.hajari.wha.service.impl.ProjectServiceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RooWebScaffold(path = "project", automaticallyMaintainView = false, formBackingObject = Project.class)
@RequestMapping("/project/**")
@Controller
public class ProjectController {

	@Autowired
	protected ProjectServiceImpl service;

	@RequestMapping(value = "/project/list/all", method = RequestMethod.GET)
	public String findAllProjects(Model model) {
		List<Project> all = service.findAll();
		model.addAttribute("items", all);
		return null;
	}

	@RequestMapping(value = "/project/byname/{name}", method = RequestMethod.GET)
	public String findProjectsByName(@PathVariable("name") String projectName, Model model) {
		if (!StringUtils.hasText(projectName)) {
			throw new IllegalArgumentException("projectName could not be empty");
		}
		List<Project> list = service.findProjectsByName(projectName);
		model.addAttribute("items", list);
		return null;
	}
}
