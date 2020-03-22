FactoryBot.define do
  factory :game do
    sequence(:title) { |n| "TEST_NAME#{n}"}
    sequence(:introduction) { |n| "TEST_INTRODUCTION#{n}"}
    sequence(:file_name) { |n| "TEST_FILE_NAME#{n}" }
  	sequence(:rating) { rand(1..10) }
  	sequence(:difficulty) { rand(1..100) }
  	user
  end
end