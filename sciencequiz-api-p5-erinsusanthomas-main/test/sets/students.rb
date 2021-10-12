module Contexts
    module Students
  
      def create_students
        # ACAC seniors
        @ellie  = FactoryBot.create(:student, organization: @acac)
        @anna   = FactoryBot.create(:student, organization: @acac, first_name: 'Anna', last_name: 'Davis', grade: 7)
        @rachel = FactoryBot.create(:student, organization: @acac, first_name: 'Rachel', last_name: 'Heimann', grade: 8, active: false)

        # Millvale juniors
        @mj     = FactoryBot.create(:student, organization: @millvale, first_name: 'MJ', last_name: 'Nelson', grade: 5)
        @mason  = FactoryBot.create(:student, organization: @millvale, first_name: 'Mason', last_name: 'Moon', grade: 4)
        @amelia = FactoryBot.create(:student, organization: @millvale, first_name: 'Amelia', last_name: 'Smith', grade: 3)
        
      end

      def create_more_students
        #ACAC seniors
        @lydia = FactoryBot.create(:student, organization: @acac, first_name: 'Lydia', last_name: 'Bailey', grade: 10)
        @sarah = FactoryBot.create(:student, organization: @acac, first_name: 'Sarah', last_name: 'Mandella', grade: 12)

        @leila  = FactoryBot.create(:student, organization: @acac, first_name: 'Leila', last_name: 'Graham', grade: 8)
        @newton = FactoryBot.create(:student, organization: @acac, first_name: 'Newton', last_name: 'Coffey', grade: 7)

        # ACAC juniors
        @miles  = FactoryBot.create(:student, organization: @acac, first_name: 'Miles', last_name: 'Bailey', grade: 6)
        @caleb  = FactoryBot.create(:student, organization: @acac, first_name: 'Caleb', last_name: 'Spahr', grade: 4)
        @naaman = FactoryBot.create(:student, organization: @acac, first_name: 'Naaman', last_name: 'Wicks', grade: 3)

        @noah   = FactoryBot.create(:student, organization: @acac, first_name: 'Noah', last_name: 'Wicks', grade: 6)
        @jacob  = FactoryBot.create(:student, organization: @acac, first_name: 'Jacob', last_name: 'Graham', grade: 3)
        @nathan = FactoryBot.create(:student, organization: @acac, first_name: 'Nathan', last_name: 'Jones', grade: 5)
        @micah  = FactoryBot.create(:student, organization: @acac, first_name: 'Micah', last_name: 'Brown', grade: 5)

        @cana   = FactoryBot.create(:student, organization: @acac, first_name: 'Cana', last_name: 'Coffey', grade: 4)
        @taylor = FactoryBot.create(:student, organization: @acac, first_name: 'Taylor', last_name: 'Cuda', grade: 5)
        @didi   = FactoryBot.create(:student, organization: @acac, first_name: 'DiDi', last_name: 'Bobo', grade: 5)
      end
      
      def destroy_students
        @ellie.destroy
        @anna.destroy
        @rachel.destroy
        @mj.destroy
        @mason.destroy
        @amelia.destroy
      end

      def destroy_more_students
        @lydia.destroy
        @sarah.destroy
        @leila.destroy
        @newton.destroy
        @miles.destroy
        @caleb.destroy
        @naaman.destroy
        @noah.destroy
        @jacob.destroy
        @nathan.destroy
        @micah.destroy
        @cana.destroy
        @taylor.destroy
        @didi.destroy
      end
  
    end
  end