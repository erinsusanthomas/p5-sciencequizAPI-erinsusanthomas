FactoryBot.define do
  factory :user do
    first_name { "Ed" }
    last_name { "Gruberman" }
    status { "coach" }
    association :organization
    active { true }
    email { |u| "#{u.first_name[0]}#{u.last_name}#{(1..99).to_a.sample}@example.com".downcase }
    phone { rand(10 ** 10).to_s.rjust(10,'0') }
    password { "secret" }
    password_confirmation { "secret" }
    # sequence :username do |n|
    #   "user#{n}"
    # end
    username {|u| "#{u.first_name[0]}#{u.last_name}"}
    active_after { 1.year.ago }
    reset_token { nil }
    reset_sent_at { nil }
  end
end
