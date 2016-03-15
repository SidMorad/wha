# Business Rules #

  * There has been no similar system for the employees so there is no stress on how they are going to get used to the new one.
  * Flat security roles are used for the system: Employee, Administrator
  * Each employee gets notified through email one day before the end of the month to sum up his time sheet, and if not, then the time sheet is closed for the current. Any changes required after each month should be done by an administrator role user.
  * Each customer (project holders) of Hajari may have different projects in their organization.
  * Each employee may work on different projects during each month.
  * The only important fact in WHA is know how much each employee works on each project for a month. Technical details of what employee has done is something internal to the customer hosting the project.

# Features #

  * Administrator can view list, add, edit, and delete customer, project, user, and employee.
  * Each human actor of the system should be assigned a user with specific roles in the system. Each user may have several roles.
  * Employee can only login to system and update the current month time sheet, or view the past time sheets he had had in the system.
  * There is a simple notification mechanism in the system through e-mail to notify the employees at the end of each month