FactoryBot.define do
  factory :comment do
    sequence(:comment) { |n| "TEST_TITLE#{n}"}
    sequence(:difficulty) { rand(1..100) }
    sequence(:rating) { rand(1..10) }
  	user
  	game
  end
end