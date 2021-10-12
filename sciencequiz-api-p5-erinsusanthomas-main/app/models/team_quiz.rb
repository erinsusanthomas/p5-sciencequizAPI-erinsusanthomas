class TeamQuiz < ApplicationRecord
  include AppHelpers::Validations

  # Relationships
  belongs_to :team
  belongs_to :quiz

  # Scopes
  scope :by_team,        -> { joins(:team).order(:name) }
  scope :by_quiz,        -> { joins(:quiz).order(:round, :room) }
  scope :by_position,    -> { order(:position) }
  scope :by_team_points, -> { order(team_points: :desc) }
  scope :for_team,       ->(team) { where(team: team) }
  scope :for_quiz,       ->(quiz) { where(quiz: quiz) }

  # Validations
  validates_presence_of :team_id, :quiz_id, :position
  validates_numericality_of :raw_score, only_integer: true, allow_blank: true
  validates_numericality_of :team_points, greater_than_or_equal_to: 0, only_integer: true, allow_blank: true
  validates_inclusion_of :position, in: [1, 2, 3], message: 'is not a valid position'
  validate -> { is_active_in_system(:team) }
  validate -> { is_active_in_system(:quiz) }
  validate -> { team_matchup_count_less_than_max }
  validate -> { matchup_position_is_currently_open }, on: :create
  validate -> { matchup_is_not_a_repeat }, on: :create


  private

  def team_matchup_count_less_than_max
    return true if (self.quiz_id.nil? || self.team_id.nil?)
    quiz = Quiz.find(self.quiz_id)
    if quiz.teams.count >= 3
      errors.add(:base, "The number of teams in this quiz is already at maximum.")
    end
  end

  def matchup_position_is_currently_open
    return true if (self.quiz_id.nil? || self.team_id.nil?)
    quiz = Quiz.find(self.quiz_id)
    matchups_for_quiz = quiz.team_quizzes
    current_positions = matchups_for_quiz.map{ |tq| tq.position }
    # current_positions = self.quiz.team_quizzes.map{ |tq| tq.position }
    if current_positions.include?(self.position) 
      errors.add(:position, "is already taken on this matchup.")
    end
  end

  def matchup_is_not_a_repeat
    return true if (self.quiz_id.nil? || self.team_id.nil?)
    quiz = Quiz.find(self.quiz_id)
    teams_for_quiz = quiz.teams
    current_team_ids = teams_for_quiz.map{ |t| t.id }
    if current_team_ids.include?(self.team_id) 
      errors.add(:team, "has already been added to this matchup.")
    end
  end

  # This version works in rails console, but not in testing; think
  # it is due to building rather than creating during testing.
  # def matchup_is_a_repeat
  #   return true if (self.quiz_id.nil? || self.team_id.nil?)
  #   current_team_ids = self.quiz.team_quizzes.map{ |tq| tq.team.id }
  #   if current_team_ids.include?(self.team_id) 
  #     errors.add(:team, "has already been added to this matchup.")
  #   end
  # end
end
