FactoryBot.define do
  factory :chat do
    sequence(:message) { |n| "TEST_MESSAGE#{n}"}
    user
    room
  end
end