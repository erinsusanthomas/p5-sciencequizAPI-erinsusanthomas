class TeamSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :division

  attribute :coach do |object|
    object.coach.proper_name
  end

  attribute :number_students do |object|
    object.students.count
  end

end
