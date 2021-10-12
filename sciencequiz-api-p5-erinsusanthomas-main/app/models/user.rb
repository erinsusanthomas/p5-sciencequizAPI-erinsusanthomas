class User < ApplicationRecord
  include AppHelpers::Activeable::InstanceMethods
  extend AppHelpers::Activeable::ClassMethods
  include AppHelpers::Validations
  include AppHelpers::Deletions
  include UserAuthentication

  has_secure_password

  # Relationships
  belongs_to :organization
  # has_many :teams, through: :organization
  has_many :teams, foreign_key: "coach_id"

  # Scopes
  scope :alphabetical, -> { order('last_name, first_name') }

  # Validations
  validates_presence_of :organization_id, :last_name, :first_name
  validates_format_of :phone, with: /\A(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})\z/, message: "should be 10 digits (area code needed) and delimited with dashes only"
  validates_format_of :email, with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, message: "is not a valid format"
  
  validates_inclusion_of :status, in: %w[admin leader coach], message: "is not an option"
  validates :username, presence: true, uniqueness: { case_sensitive: false}
  validates_presence_of :password, on: :create 
  validates_presence_of :password_confirmation, on: :create 
  validates_confirmation_of :password, on: :create, message: 'does not match'
  validates_length_of :password, minimum: 4, message: 'must be at least 4 characters long', allow_blank: true


  # Other methods
  def name
    "#{last_name}, #{first_name}"
  end
  
  def proper_name
    "#{first_name} #{last_name}"
  end

  # Callbacks
  before_save    -> { strip_nondigits_from(:phone) }
  before_destroy -> { cannot_destroy_object() }


end
