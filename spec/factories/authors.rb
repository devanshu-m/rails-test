FactoryBot.define do
  factory :author do
  	first_name "John"
  	last_name "Doe"
    sequence(:email) { |n| "test#{n}@test.com" }
    password "anysecretpwd"
  end
end
