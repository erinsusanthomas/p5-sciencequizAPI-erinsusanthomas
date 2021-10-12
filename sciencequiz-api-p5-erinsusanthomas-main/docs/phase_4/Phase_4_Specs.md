Model Specifications for ScienceQuiz: Phase 4
---

In phase 4, you will have to create models for `User`, `Event`, `Quiz`, `TeamQuiz` and `StudentQuiz` and write code and unit tests for these models. In addition, you will have to make a number of adjustments to existing models.  In order to make sure you are able to build these models and tests properly so they pass our tests at the end of the phase, here are some specs for each of the models:

**Organizations must:**

1. pass all new relational tests
2. continue to pass previous tests from phase 2


**Teams must:**

1. pass all new relational tests
2. continue to pass previous tests from phase 2
3. should not be destroyed if the team has ever participated in a quiz; otherwise it can be destroyed. (Do _not_ assume extra business logic is needed; while more could be done, in this case we have kept it simple.)


**Students must:**

1. pass all new relational tests
2. continue to pass previous tests from phase 2
3. should allow a student to be destroyed if he/she has never participated in a quiz (as indicated by an associated record in the student_quiz table)
4. if a student is destroyed, then his/her current assignment in the student_teams table should also be destroyed
5. if a student cannot be destroyed, then the student should be made inactive and his/her current team assignment is terminated
6. If a student is made inactive, then his/her current team assignment is automatically terminated as well


**StudentTeams must:**

1. continue to pass previous tests from phase 2
2. pass the custom validation test found in `test/models/student_team/student_team_test.rb`


**Events must:**

1. pass all relationship tests provided
2. pass all validation tests provided
3. have the following scopes:
	- `active` -- returns only active events
	- `inactive` -- returns only inactive events
	- `chronological` -- orders results chronologically by date
	- `past` -- returns only events happened in the past
	- `upcoming` -- returns only events that are today or in the future
	- `for_organization` -- returns all the events for a given organization (parameter: organization)
4.	have a method called `make_active` which changes the status from inactive to active and saves the change in the database
5. have a method called `make_inactive` which changes the status from active to inactive and saves the change in the database


**Quizzes must:**

1. pass all relationship tests provided
2. pass all validation tests provided
3. have the following scopes:
	- `by_room` -- orders results by room number
	- `by_round` -- orders results by round number
	- `for_room` -- returns only quizzes for a given room (parameter: room)
	- `for_round` -- returns only quizzes for a given round (parameter: round)
	- `seniors` -- returns only quizzes for the senior division
	- `juniors` -- returns only quizzes for the junior division
	- `for_event` -- returns all the quizzes for a given event (parameter: event)


**Users must:**

1. pass all relationship tests provided
2. pass all validation tests provided
3. have the following scopes:
	- `active` -- returns only active users
	- `inactive` -- returns only inactive users
	- `alphabetical` -- orders results alphabetically by user's last, first names
4.	have a method called `make_active` which changes the status from inactive to active and saves the change in the database
5. have a method called `make_inactive` which changes the status from active to inactive and saves the change in the database
6. have a method called `name` which returns the student's full name as "last-name, first-name"
7. have a method called `proper_name` which returns the student's full name as "first-name last-name"
8. have a secure password
9. have a method called `role?` which returns true if the user's status matches the role in question (e.g., `:admin`)
10. have a class method called `authenticate` which takes a username and password and attempts to authenticate the user based on the password digest saved for that user in the system
11. save phone numbers in the database as a string consisting only of digits
12. cannot be destroyed for any reason


**TeamQuizzes must:**

1. pass all relationship tests provided
2. pass all validation tests provided
3. have the following scopes:
	- `by_team` -- orders results alphabetically by team
	- `by_quiz` -- orders results by round, then room number
	- `by_position` -- orders results by position
	- `by_team_points` -- orders results by team points in descending order
	- `for_team` -- returns all the team-quizzes for a given team (parameter: team)
	- `for_quiz` -- returns all the team-quizzes for a given quiz (parameter: quiz)


**StudentQuizzes must:**

1. pass all relationship tests provided
2. pass all validation tests provided
3. have the following scopes:
	- `by_student` -- orders results alphabetically by student's last, first names
	- `by_quiz` -- orders results by round, then room number
	- `by_score` -- orders results by score in descending order
	- `for_student` -- returns all the student-quizzes for a given student (parameter: student)
	- `for_quiz` -- returns all the student-quizzes for a given quiz (parameter: quiz)
4. have a callback that automatically converts the number of correct answers and the number of questions attempted and converts that into the appropriate student score.  This should work before both updating and inserting a record.
