package nl.hajari.wha.web.report;

import java.util.Enumeration;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JasperPrint;

import org.springframework.web.servlet.view.jasperreports.JasperReportsMultiFormatView;

/**
 * This calss override renderReport() method for replace report name .
 * 
 * @author <a href="mailto:saeid3@gmail.com">Saeid Moradi</a>
 */
public class CustomJasperReportsMultiFormatView extends
		JasperReportsMultiFormatView {

	@Override
	protected void renderReport(JasperPrint populatedReport,
			Map<String, Object> model, HttpServletResponse response)
			throws Exception {

		// replace content disposition header filename with report names.
		Properties contentDispositions = this.getContentDispositionMappings();

		Enumeration enumContDispKeys = contentDispositions.keys();
		// iterate over all disposition mappings and replace the word
		// _replace_name_ with the reportName
		while (enumContDispKeys.hasMoreElements()) {
			Object contDispKey = enumContDispKeys.nextElement();
			// check whether string before cast.
			if (contDispKey instanceof String) {
				// get the disposition string
				String dispositionString = contentDispositions
						.getProperty((String) contDispKey);
				// set the new value in the properties
				this.getContentDispositionMappings().setProperty((String) contDispKey,
						dispositionString.replace("_replace_name_",
								populatedReport.getName()));
			}
		}
		super.renderReport(populatedReport, model, response);
	}
}
