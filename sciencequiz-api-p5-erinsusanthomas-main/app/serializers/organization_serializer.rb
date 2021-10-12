class OrganizationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :street_1, :city, :state, :zip, :short_name
  
  attribute :active_teams do |object|
    if object.teams.active.empty?
      "No active teams currently!"
    else
      object.teams.active.map do |team|
        TeamSerializer.new(team)
      end
    end
  end

  attribute :inactive_teams do |object|
    if object.teams.inactive.empty?
      "No inactive teams currently!"
    else
      object.teams.inactive.map do |team|
        TeamSerializer.new(team)
      end
    end
  end

end
