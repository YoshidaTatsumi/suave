FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "TEST_NAME#{n}"}
    sequence(:introduction) { |n| "TEST_INTRODUCTION#{n}"}
    sequence(:email) { |n| "TEST#{n}@example.com"}
    sequence(:password) { 'Pass42' }
  	sequence(:password_confirmation) { 'Pass42' }
  end
end