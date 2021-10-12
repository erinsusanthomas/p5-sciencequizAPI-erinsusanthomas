Model Specifications for ScienceQuiz: Phase 2
---

In phase 2, you will have to create models for `Organization`, `Student`, `Team` and
`StudentTeam` and write code and unit tests for these models. To make sure you are able to
build these models and tests properly so they pass our tests at the end of the phase, here are some specs for each of the models:

**Organizations must:**

1.	have all proper relationships specified
2. have a name, street 1, zip, and short name
3. only allow US states to be entered as a state
4. have a valid zip code
5. have a short name that is unique in the system (case insensitive)
6. have the following scopes:
	- `active` -- returns only active organizations
	- `inactive` -- returns only inactive organizations
	- `alphabetical` -- orders results alphabetically
7.	have a method called `make_active` which changes the status from inactive to active and saves the change in the database
8. have a method called `make_inactive` which changes the status from active to inactive and saves the change in the database


**Teams must:**

1. have all proper relationships specified
2. have a first name, division, and affiliated organization
3. belong to an organization that is active in ScienceQuiz when first created
4. must be in a valid division
5. have the following scopes:
	- `active` -- returns only active teams
	- `inactive` -- returns only inactive teams
	- `alphabetical` -- orders results alphabetically
	- `juniors` -- returns only teams who are in the junior division
	- `seniors` -- returns only teams who are in the senior division
	- `for_organization` -- returns all the teams for a given organization (parameter: organization)
6.	have a method called `make_active` which changes the status from inactive to active and saves the change in the database
7. have a method called `make_inactive` which changes the status from active to inactive and saves the change in the database


**Students must:**

1. have all proper relationships specified
2. have a first name, last name, grade, and affiliated organization
3. belong to an organization that is active in ScienceQuiz when first created
4. have a grade that is at least 3rd grade and not higher than 12th grade
5. have the following scopes:
	- `active` -- returns only active students
	- `inactive` -- returns only inactive students
	- `alphabetical` -- orders results alphabetically by student's last, first names
	- `juniors` -- returns only students who are in the junior division
	- `seniors` -- returns only students who are in the senior division
6.	have a method called `make_active` which changes the status from inactive to active and saves the change in the database
7. have a method called `make_inactive` which changes the status from active to inactive and saves the change in the database
8. have a method called `current_team` which return a team object representing the team the student is currently registered with, or nil if no such registration exists
9. have a method called `junior?` which returns true if the student is in the junior division and false otherwise
10. have a method called `name` which returns the student's full name as "last-name, first-name"
11. have a method called `proper_name` which returns the student's full name as "first-name last-name"


**StudentTeams must:**

1. have all proper relationships specified
2. have a start date, position, and affiliated student and team
3. be connected to a student that is active in ScienceQuiz when first created
4. be connected to a team that is active in ScienceQuiz when first created
5. have a valid position
6. have no start dates in the future or end dates that precede start dates
7. have the following scopes:
	- `active` -- returns only active teams
	- `inactive` -- returns only inactive teams
	- `alphabetical` -- orders results alphabetically by student's last, first names
	- `chronological` -- orders results chronologically by start_date
	- `by_position` -- orders results by position
	- `captains` -- returns only records for the #1 ranked member of each team
	- `for_team` -- returns all the records for a given team (parameter: team)
	- `for_student` -- returns all the records for a given student (parameter: student)
	- `current` -- returns all the current student-team assignments
	- `past` -- returns all the past student-team assignments
8.	have a method called `make_active` which changes the status from inactive to active and saves the change in the database
9. have a method called `make_inactive` which changes the status from active to inactive and saves the change in the database
10. have a method called `end_previous_team_assignment` -- this method will be used as a part of a callback when creating a new student-team assignment. (Callbacks will be explained later in class). Essentially this method and callback will update any previously open student-team assignment (if applicable) and terminate it by automatically by setting the end date of the old student-team assignment to the start date of the new student-team assignment.



