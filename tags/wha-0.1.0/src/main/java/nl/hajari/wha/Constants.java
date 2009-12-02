package nl.hajari.wha;

public class Constants {

	public static final String ROLE_PREFIX = "ROLE_";
	public static final String ROLE_ADMIN = Role.Admin.toString();
	public static final String ROLE_EMPLOYEE = Role.Employee.toString();

	/**
	 * An enumerated type to hold the types of roles we have in the system.
	 * 
	 * @author behrooz
	 */
	public enum Role {

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

}
