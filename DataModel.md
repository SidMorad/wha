# Data Entities #

  * User = (id, username, password, roles(1-n))
  * Role = (id, name)
  * Technical Role = (id, name, pay rate)
  * Employee = (id, first name, last name, employee id, user(1-1), tech role, pay rate)
  * Hourly Timesheet = (id, date, from hour, to hour, project, customer, hours, hourly offs, training hours)
  * Daily Timesheet = (id, date, daily total, hourly timesheets(1-n))
  * Timesheet = (id, month, year, monthly total, daily timesheets(1-n))
  * We need some constants: (how to model?)
    * Constants = (id, key, value) => Sample: VAT percentage: 19%