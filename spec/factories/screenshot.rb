FactoryBot.define do
  factory :screenshot do
    sequence(:image_id) { |n| "TEST_IMAGE_ID#{n}"}
    game
  end
end