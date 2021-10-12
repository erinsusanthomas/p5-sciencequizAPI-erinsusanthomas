class Organization < ApplicationRecord
  include AppHelpers::Deletions
  include AppHelpers::Activeable::InstanceMethods
  extend AppHelpers::Activeable::ClassMethods

  # Relationships
  has_many :students
  has_many :teams
  has_many :student_teams, through: :teams
  has_many :users

  # Scopes
  scope :alphabetical, -> { order('name') }

  # Validations
  STATES_LIST = [['Alabama', 'AL'],['Alaska', 'AK'],['Arizona', 'AZ'],['Arkansas', 'AR'],['California', 'CA'],['Colorado', 'CO'],['Connectict', 'CT'],['Delaware', 'DE'],['District of Columbia ', 'DC'],['Florida', 'FL'],['Georgia', 'GA'],['Hawaii', 'HI'],['Idaho', 'ID'],['Illinois', 'IL'],['Indiana', 'IN'],['Iowa', 'IA'],['Kansas', 'KS'],['Kentucky', 'KY'],['Louisiana', 'LA'],['Maine', 'ME'],['Maryland', 'MD'],['Massachusetts', 'MA'],['Michigan', 'MI'],['Minnesota', 'MN'],['Mississippi', 'MS'],['Missouri', 'MO'],['Montana', 'MT'],['Nebraska', 'NE'],['Nevada', 'NV'],['New Hampshire', 'NH'],['New Jersey', 'NJ'],['New Mexico', 'NM'],['New York', 'NY'],['North Carolina','NC'],['North Dakota', 'ND'],['Ohio', 'OH'],['Oklahoma', 'OK'],['Oregon', 'OR'],['Pennsylvania', 'PA'],['Rhode Island', 'RI'],['South Carolina', 'SC'],['South Dakota', 'SD'],['Tennessee', 'TN'],['Texas', 'TX'],['Utah', 'UT'],['Vermont', 'VT'],['Virginia', 'VA'],['Washington', 'WA'],['West Virginia', 'WV'],['Wisconsin', 'WI'],['Wyoming', 'WY']].freeze

  validates_presence_of :name, :street_1, :zip, :short_name
  validates_format_of :zip, with: /\A\d{5}\z/, message: "should be five digits long", allow_blank: false
  validates_inclusion_of :state, in: STATES_LIST.map {|key, value| value}, message: "is not an option", allow_blank: true
  validates_uniqueness_of :short_name, case_sensitive: false

  # Callback - to prevent deletions
  before_destroy -> { cannot_destroy_object() }

end
