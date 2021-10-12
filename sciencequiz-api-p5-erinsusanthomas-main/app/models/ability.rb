# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # aliasing both update and destroy to modify
    alias_action :update, :destroy, :to => :modify
    user ||= User.new # i.e., a guest user
    
    # set authorizations for different user roles
    if user.role? :admin
      can :manage, :all
    end
      
    if user.role? :leader
      can :read, :all
      can :modify, Organization do |this_org|
        this_org.id == user.organization_id
      end
      can :create, User
      can :modify, User do |this_user|
        my_users = user.organization.users.to_a
        my_users.include?(this_user)
      end
      can :create, Team
      can :create, StudentTeam
      can :modify, Team do |this_team|
        my_teams = user.organization.teams.to_a
        my_teams.include?(this_team)
      end
      can :modify, StudentTeam do |this_assignment|
        my_assignments = user.organization.student_teams.to_a
        my_assignments.include?(this_assignment)
      end
    end

    if user.role? :coach
      can :index, Team
      can :index, Student
      can :index, Organization
      can :index, Event
      can :index, Quiz
      can :show, Event
      can :show, Quiz
      can :show, Organization do |this_org|
        this_org.id == user.organization_id
      end
      can :show, Student do |this_student|
        my_students = user.organization.students.to_a
        my_students.include?(this_student)
      end
      can :modify, Student do |this_student|
        my_students = user.teams.map{|t| t.students}.flatten
        my_students.include?(this_student)
      end
      can :update, StudentTeam do |this_assignment|
        my_assignments = user.teams.map{|t| t.student_teams}.flatten
        my_assignments.include?(this_assignment)
      end
    end

  end
end