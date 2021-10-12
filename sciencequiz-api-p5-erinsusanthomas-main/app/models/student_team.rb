class StudentTeam < ApplicationRecord
  include AppHelpers::Activeable::InstanceMethods
  extend AppHelpers::Activeable::ClassMethods
  include AppHelpers::Validations

  # Relationships
  belongs_to :student
  belongs_to :team

  # Scopes
  scope :by_position,   -> { order(:position) }
  scope :alphabetical,  -> { joins(:student).order('last_name, first_name') }
  scope :chronological, -> { order(:start_date) }
  scope :for_team,      ->(team) { where('team_id =?', team.id) }
  scope :for_student,   ->(student) { where(student: student) }
  scope :captains,      -> { where(position: 1) }
  scope :current,       -> { where('end_date IS NULL') }
  scope :past,          -> { where('end_date IS NOT NULL') }

  # Validations
  validates_presence_of :start_date, :position, :student_id, :team_id
  validates_numericality_of :position, greater_than: 0, less_than: 6, only_integer: true
  validates_date :start_date, on_or_before: ->{ Date.current }, on_or_before_message: "cannot be in the future"
  validates_date :end_date, on_or_after: :start_date, on_or_before: ->{ Date.current }, allow_blank: true
  validate -> { is_active_in_system(:student) }, on: :create
  validate -> { is_active_in_system(:team) }, on: :create

  validate -> { student_has_appropriate_grade_given_team_division }, on: :create
  validate -> { student_is_aligned_with_team_organization }, on: :create
  validate -> { student_position_is_currently_open }, on: :create
  validate -> { student_assignment_is_not_a_repeat }, on: :create


  # Other methods
  def terminate_now
    current_assignment = self.student.student_teams.current.first
    if current_assignment.nil?
      return true 
    else
      current_assignment.end_date = Date.current
      current_assignment.update_attribute(:end_date, Date.current)
    end
  end

  # Callbacks
  before_create :end_previous_team_assignment

  private
  def end_previous_team_assignment
    current_assignment = self.student.student_teams.current.first
    if current_assignment.nil?
      return true 
    else
      current_assignment.update_attribute(:end_date, self.start_date.to_date)
    end
  end

  def student_is_aligned_with_team_organization
    return true if (self.student_id.nil? || self.team_id.nil?)
    team = Team.find(self.team_id)
    team_organization = team.organization
    team_organization_students_ids = team_organization.students.map{ |s| s.id }
    # team_organization_students_ids = self.team.organization.students.map{ |s| s.id }
    unless team_organization_students_ids.include?(self.student_id)
      errors.add(:student, "is not a member of this team's organization.")
    end
  end

  def student_has_appropriate_grade_given_team_division
    return true if (self.student_id.nil? || self.team_id.nil?)
    if (self.student.junior? && !self.team.junior?) || (!self.student.junior? && self.team.junior?)
      errors.add(:student, "is not eligible for this team's division.")
    end
  end

  def student_position_is_currently_open
    return true if (self.student_id.nil? || self.team_id.nil?)
    team = Team.find(self.team_id)
    current_assignments_for_this_team = team.student_teams.current
    return true if current_assignments_for_this_team.empty?
    current_positions = current_assignments_for_this_team.map{ |st| st.position }
    if current_positions.include?(self.position) 
      errors.add(:position, "is already taken on this team.")
    end
  end

  def student_assignment_is_not_a_repeat
    return true if (self.student_id.nil? || self.team_id.nil?)
    student = self.student#Student.find(self.student_id)
    if !student.current_team.nil? && (student.current_team.id == self.team_id)
      errors.add(:team, "has already been assigned to this team.")
    end
  end
end
