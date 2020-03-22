FactoryBot.define do
  factory :contact do
    sequence(:title) { |n| "TEST_TITLE#{n}"}
    sequence(:content) { |n| "TEST_CONTENT#{n}"}
    sequence(:reply_content) { |n| "TEST_REPLY_CONTENT#{n}" }
  	sequence(:status) { false }
  	user
  end
end