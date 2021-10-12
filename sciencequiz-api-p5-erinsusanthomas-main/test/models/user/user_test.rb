require "test_helper"

class UserTest < ActiveSupport::TestCase
  # Matchers
  should belong_to(:organization)
  should have_many(:teams)

  should have_secure_password

  should validate_presence_of(:organization_id)
  should validate_presence_of(:last_name)
  should validate_presence_of(:first_name)

  should allow_value("fred@fred.com").for(:email)
  should allow_value("fred@andrew.cmu.edu").for(:email)
  should allow_value("my_fred@fred.org").for(:email)
  should allow_value("fred123@fred.gov").for(:email)
  should allow_value("my.fred@fred.net").for(:email)
  
  should_not allow_value("fred").for(:email)
  should_not allow_value("fred@fred,com").for(:email)
  should_not allow_value("fred@fred.uk").for(:email)
  should_not allow_value("my fred@fred.com").for(:email)
  should_not allow_value("fred@fred.con").for(:email)
  
  should allow_value("4122683259").for(:phone)
  should allow_value("412-268-3259").for(:phone)
  should allow_value("412.268.3259").for(:phone)
  should allow_value("(412) 268-3259").for(:phone)
  
  should_not allow_value("2683259").for(:phone)
  should_not allow_value("4122683259x224").for(:phone)
  should_not allow_value("800-EAT-FOOD").for(:phone)
  should_not allow_value("412/268/3259").for(:phone)
  should_not allow_value("412-2683-259").for(:phone)

end