FactoryBot.define do
  factory :procedure do
    title {Faker::Lorem.sentences(number: 1)}
    description {Faker::Lorem.sentences}

    association :manual
    association :user

    after(:build) do |procedure|
      procedure.image.attach(io: File.open('public/images/test_image.jpg'), filename: 'test_image.jpg')
    end
  end
end
