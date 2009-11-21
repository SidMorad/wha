package nl.hajari.wha.domain.enums;

/**
 * An enumerated type to represents Month in our system.
 * 
 * @author Saeid Moradi
 * @since 1.0 
 */
public enum Month {
    JAN(1), FEB(2), MAR(3), APR(4), MAY(5), JUN(6), JUL(7), AUG(8), SEP(9), OCT(10), NOV(11), DEC(12);

    private Integer value;
    
    Month(Integer value) {
    	this.value = value;
    }
    
    @Override
    public String toString() {
    	//TODO return localized lable here 
    	return "m " + value;
    }
}
