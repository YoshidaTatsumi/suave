FactoryBot.define do
  factory :room do
    sequence(:name) { |n| "TEST_NAME#{n}"}
    sequence(:introduction) { |n| "TEST_INTRODUCTION#{n}"}
    user
  end
end