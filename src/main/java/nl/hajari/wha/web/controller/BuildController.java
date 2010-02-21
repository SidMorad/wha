package nl.hajari.wha.web.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.jar.Attributes;
import java.util.jar.Manifest;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class BuildController extends AbstractController {

	@RequestMapping(value = "/build", method = RequestMethod.GET)
	public String showBuildInfo(ModelMap modelMap, HttpServletRequest request) {
		String appServerHome = request.getSession().getServletContext().getRealPath("/");
		File manifestFile = new File(appServerHome, "META-INF/MANIFEST.MF");
		Manifest mf = new Manifest();
		try {
			mf.read(new FileInputStream(manifestFile));
		} catch (FileNotFoundException e) {
			throw new IllegalStateException(e);
		} catch (IOException e) {
			throw new IllegalStateException(e);
		}
		Attributes atts = mf.getMainAttributes();
		modelMap.addAttribute("implVersion", atts.getValue("Implementation-Version"));
		modelMap.addAttribute("implBuild", atts.getValue("Implementation-Build"));
		modelMap.addAttribute("implDate", atts.getValue("Implementation-Date"));
		modelMap.addAttribute("implTitle", atts.getValue("Implementation-Title"));
		modelMap.addAttribute("implVendor", atts.getValue("Implementation-Vendor"));
		modelMap.addAttribute("implVendorId", atts.getValue("Implementation-Vendor-Id"));
		modelMap.addAttribute("createdBy", atts.getValue("Created-By"));
		modelMap.addAttribute("buildJdk", atts.getValue("Build-Jdk"));
		modelMap.addAttribute("buildBy", atts.getValue("Built-By"));
		return "build";
	}

}
