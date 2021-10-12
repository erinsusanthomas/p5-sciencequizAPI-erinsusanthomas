class Team < ApplicationRecord
  include AppHelpers::Activeable::InstanceMethods
  extend AppHelpers::Activeable::ClassMethods
  include AppHelpers::Validations

  DIVISION_LIST = [['Junior', 'junior'],['Senior', 'senior']].freeze

  # Relationships
  belongs_to :organization
  has_many :student_teams
  has_many :students, through: :student_teams
  has_many :team_quizzes
  has_many :quizzes, through: :team_quizzes
  belongs_to :coach, class_name: "User"

  # Scopes
  scope :alphabetical, -> { order(:name) }
  scope :by_division, -> { order(:division) }
  scope :for_organization, ->(organization) { where(organization_id: organization.id) }
  scope :juniors, -> { where(division: 'junior') }
  scope :seniors, -> { where(division: 'senior') }

  # Validations
  validates_presence_of :name, :division, :organization_id
  validates_inclusion_of :division, in: %w[senior junior], message: 'is not a valid division'
  validate -> { is_active_in_system(:organization) }, on: :create

  # Other methods
  def junior?
    self.division == 'junior'
  end

  # Callback - to handle destroying teams
  before_destroy do 
    check_if_team_ever_in_a_quiz
    if errors.present?
      throw(:abort)
    end
  end

  private
  def check_if_team_ever_in_a_quiz
    unless self.team_quizzes.empty?
      errors.add(:base, "Team cannot be deleted because it has participated in some quizzes.")
    end
  end

end
