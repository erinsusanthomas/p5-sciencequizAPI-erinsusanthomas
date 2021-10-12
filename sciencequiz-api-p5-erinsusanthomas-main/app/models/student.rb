class Student < ApplicationRecord
  include AppHelpers::Activeable::InstanceMethods
  extend AppHelpers::Activeable::ClassMethods
  include AppHelpers::Validations

  # Relationships
  belongs_to :organization
  has_many :student_teams
  has_many :teams, through: :student_teams
  has_many :student_quizzes
  has_many :quizzes, through: :student_quizzes
  attr_accessor :destroyable

  # Scopes
  scope :alphabetical, -> { order('last_name, first_name') }
  scope :juniors, -> { where('grade < 7') }
  scope :seniors, -> { where('grade > 6') }
  scope :for_organization, ->(organization) { where(organization_id: organization.id) }

  # Validations
  validates_presence_of :first_name, :last_name, :grade, :organization_id
  validates_numericality_of :grade, greater_than: 2, less_than: 13, only_integer: true
  validate -> { is_active_in_system(:organization) }, on: :create

  # Methods
  def name
    "#{last_name}, #{first_name}"
  end
  
  def proper_name
    "#{first_name} #{last_name}"
  end

  def junior?
    grade < 7
  end

  def current_team
    curr_team = self.student_teams.current    
    return nil if curr_team.empty?
    curr_team.first.team   # return as a single object, not an array
  end

  # Handling deletions and inactive students
  include StudentDeletion
  before_destroy -> { handle_deletion_request() }
  after_rollback -> { handle_deletion_failure() }
  before_save    -> { remove_team_assignment_for_inactive_student() }
  
end
