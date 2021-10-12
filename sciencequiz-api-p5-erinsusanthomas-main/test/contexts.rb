# require needed files
require './test/sets/students'
require './test/sets/organizations'
require './test/sets/teams'
require './test/sets/users'
require './test/sets/events'
require './test/sets/quizzes'
require './test/sets/student_teams'
require './test/sets/student_quizzes'
require './test/sets/team_quizzes'
require './test/sets/abilities'


module Contexts
  # explicitly include all sets of contexts used for testing
  include Contexts::Students
  include Contexts::Organizations
  include Contexts::Teams
  include Contexts::Users
  include Contexts::Events
  include Contexts::Quizzes
  include Contexts::StudentTeams
  include Contexts::StudentQuizzes
  include Contexts::TeamQuizzes
  include Contexts::Abilities

  
  def create_all
    # puts "Building context..."
    create_organizations
    # puts "Built organizations"
    create_users
    # puts "Built users"
    create_teams
    # puts "Built teams"
    create_students
    # puts "Built students"
    create_events
    # puts "Built events"
    create_quizzes
    # puts "Built quizzes"
    create_student_teams
    # puts "Built student teams"
    create_team_quizzes
    # puts "Built team quizzes"
    create_student_quizzes
    # puts "Built student quizzes"
    puts "Context built"
  end
  
end
