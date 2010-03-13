package nl.hajari.wha;

public abstract class Constants {

	public static final String ROLE_PREFIX = "ROLE_";
	public static final String ROLE_ADMIN = Role.Admin.toString();
	public static final String ROLE_EMPLOYEE = Role.Employee.toString();
	public static final String IMAGE_HM_LOGO = "IMAGE_HM_LOGO";
	public static final String imageHMlogoAddress = "images/HM_100x70.jpg";
	public static final String DATE_PATTERN_KEY = "date.pattern";	
	
	/**
	 * An enumerated type to hold the types of roles we have in the system.
	 * 
	 * @author behrooz
	 */
	enum Role {

		Admin("admin"), Employee("employee");

		private String name;

		private Role(String name) {
			this.name = name.toUpperCase();
		}

		@Override
		public String toString() {
			return ROLE_PREFIX + name;
		}
	}
	
	private Constants() {
	}

}
