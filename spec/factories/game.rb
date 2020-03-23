FactoryBot.define do
  factory :game do
    sequence(:title) { |n| "TEST_NAME#{n}"}
    sequence(:introduction) { |n| "TEST_INTRODUCTION#{n}"}
    sequence(:file) { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/japan.jpg')) }
  	sequence(:rating) { rand(1..10) }
  	sequence(:difficulty) { rand(1..100) }
  	user
  end
end