module Contexts
    module Abilities
      
      def create_admin_abilities
        @alex = FactoryBot.create(:user, first_name: "Alex", username: "alex", last_name: "Heimann", status: "admin")
        @alex_ability = Ability.new(@alex)
      end
      
      def create_leader_abilities
        # created related objects for testing
        create_all
        # make the leader ability using Kathryn (ACAC)
        @kathryn_ability = Ability.new(@kathryn)
      end

      def create_coach_abilities
        # created related objects for testing
        create_all
        # make the coach ability using Sophie (ACAC)
        @sophie_ability = Ability.new(@sophie)
      end
  
    end
  end