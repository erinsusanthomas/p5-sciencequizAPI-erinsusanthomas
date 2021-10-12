class StudentQuiz < ApplicationRecord
  include AppHelpers::Validations

  # Relationships
  belongs_to :student
  belongs_to :quiz

  # Scopes
  scope :by_student,  -> { joins(:student).order(:last_name, :first_name) }
  scope :by_score,    -> { order(score: :desc) }
  scope :by_quiz,     -> { joins(:quiz).order(:round, :room) }
  scope :for_student, ->(student) { where(student: student) }
  scope :for_quiz,    ->(quiz) { where(quiz: quiz) }

  # Validations
  validates_presence_of :student_id, :quiz_id, :num_attempted, :num_correct
  validates_numericality_of :num_attempted, greater_than_or_equal_to: 0, less_than: 7, only_integer: true
  validates_numericality_of :num_correct, greater_than_or_equal_to: 0, less_than: 5, only_integer: true
  validate -> { student_is_participating_in_this_quiz }
  validate -> { is_active_in_system(:quiz) }

  # Callback
  before_save :set_student_quiz_score

  private

  def student_is_participating_in_this_quiz
    return true if (self.student_id.nil? || self.quiz_id.nil?)
    quiz = Quiz.find(self.quiz_id)
    matchups_for_quiz = quiz.team_quizzes
    ids_for_current_students = matchups_for_quiz.map{ |tq| tq.team.students.map{|s| s.id}}.flatten
    unless ids_for_current_students.include?(self.student_id)
      errors.add(:student, "is not participating in this quiz")
    end
  end

  def set_student_quiz_score
    self.score = calculate_student_quiz_score
  end

  def calculate_student_quiz_score
    student_score = calculate_base_score()
    student_score = add_bonus(student_score)
    student_score = subtract_penalties(student_score)
    return student_score
  end

  def calculate_base_score
    base = 20 * self.num_correct
  end

  def add_bonus(score)
    if (self.num_correct == 4) && (self.num_attempted == 4)
      score += 10
    end
    return score
  end

  def subtract_penalties(score)
    if (self.num_attempted - self.num_correct) == 2 
      score -= 10
    elsif (self.num_attempted - self.num_correct) == 3
      score -= 20
    end
    return score
  end

end
