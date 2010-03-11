/*
 * Created on 11/03/2010 - 9:41:43 PM 
 */
package nl.hajari.wha.web.util;

import java.math.BigDecimal;

/**
 *
 *
 * @author <a href="mailto:saeid3@gmail.com">Saeid Moradi</a>	
 */
public class MathUtils {
	
	public static double roundToTwoDecimalPlaces(float num) {
		BigDecimal bd = new BigDecimal(num);
		bd = bd.setScale(2, BigDecimal.ROUND_HALF_UP);
		return bd.doubleValue();
	}

	public static double roundToTwoDecimalPlaces(double num) {
		BigDecimal bd = new BigDecimal(num);
		bd = bd.setScale(2, BigDecimal.ROUND_HALF_UP);
		return bd.doubleValue();
	}
	
}
