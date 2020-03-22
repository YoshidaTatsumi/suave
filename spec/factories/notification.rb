FactoryBot.define do
  factory :notification do
    sequence(:action) {"comment"}
    sequence(:checked) {false}
    User
  	game
  	comment
  end
end