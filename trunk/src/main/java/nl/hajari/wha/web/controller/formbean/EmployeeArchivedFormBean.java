package nl.hajari.wha.web.controller.formbean;

public class EmployeeArchivedFormBean {

	private boolean archived;

	public EmployeeArchivedFormBean() {}
	
	public EmployeeArchivedFormBean(boolean archived) {
		this.archived= archived;
	}

	public boolean isArchived() {
		return archived;
	}

	public void setArchived(boolean archived) {
		this.archived = archived;
	}
}
