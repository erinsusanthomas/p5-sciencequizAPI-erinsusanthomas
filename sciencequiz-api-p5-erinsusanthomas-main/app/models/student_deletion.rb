module StudentDeletion
  
  def handle_deletion_request 
    check_if_ever_participated_in_a_quiz()
    if self.errors.present?
      self.destroyable = false
      throw(:abort)
    end
    destroy_current_assignment_if_student_destroyed()
  end

  def handle_deletion_failure
    if self.destroyable == false
      convert_to_inactive()
      remove_current_assignment()
    end
  end

  private
    def check_if_ever_participated_in_a_quiz
      unless self.student_quizzes.empty?
        errors.add(:base, "Student cannot be deleted because of previous participation, but student status has been set to inactive.")
      end
    end

    def convert_to_inactive
      self.make_inactive
    end

    def destroy_current_assignment_if_student_destroyed
      current_assignment = self.student_teams.current.first
      current_assignment.destroy
    end
  
    def remove_current_assignment
      current_assignment = self.student_teams.current.first
      current_assignment.terminate_now unless current_assignment.nil?
    end

    def remove_team_assignment_for_inactive_student
      return true if self.active 
      remove_current_assignment
    end

end