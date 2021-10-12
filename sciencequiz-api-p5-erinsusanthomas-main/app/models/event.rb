class Event < ApplicationRecord
  include AppHelpers::Validations
  include AppHelpers::Activeable::InstanceMethods
  extend AppHelpers::Activeable::ClassMethods

  # Relationships
  belongs_to :organization
  has_many :quizzes

  # Scopes
  scope :chronological, -> { order(:date) }
  scope :past, -> { where('date < ?', Date.current) }
  scope :upcoming, -> { where('date >= ?', Date.current) }
  scope :for_organization, ->(organization) { where(organization_id: organization.id) }

  # Validations
  validates_presence_of :organization_id
  validates_date :date
  validate -> { is_active_in_system(:organization) }, on: :create


end
