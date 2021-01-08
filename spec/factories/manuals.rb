FactoryBot.define do
  factory :manual do
    title { Faker::Lorem.sentences(number: 1) }
    category_id { Faker::Number.between(from: 1, to: 10) }
    description { Faker::Lorem.sentences }

    association :user

    after(:build) do |manual|
      manual.image.attach(io: File.open('public/images/test_image.jpg'), filename: 'test_image.jpg')
    end
  end
end
