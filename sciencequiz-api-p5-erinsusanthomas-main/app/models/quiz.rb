class Quiz < ApplicationRecord
  include AppHelpers::Validations

  belongs_to :event
  has_many :team_quizzes
  has_many :teams, through: :team_quizzes
  has_many :student_quizzes
  has_many :students, through: :student_quizzes

  # Scopes
  scope :by_room,   -> { order(:room) }
  scope :by_round,  -> { order(:round) }
  scope :for_room,  ->(room) { where(room: room) }
  scope :for_round, ->(round) { where(round: round) }
  scope :seniors,   -> { where(division: 'senior') }
  scope :juniors,   -> { where(division: 'junior') }
  scope :for_event, ->(event) { where(event: event) }

  # Validations
  validates_presence_of :event_id, :division, :room, :round
  validates_numericality_of :round, greater_than: 0, only_integer: true
  validates_numericality_of :room, greater_than: 0, only_integer: true
  validates_inclusion_of :division, in: %w[senior junior], message: 'is not a valid division'
  validate -> { is_active_in_system(:event) }, on: :create

end
