FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "kingren#{n}" }
    sequence(:email) { |n| "factory-#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    user_private { false }
  end
end
