FactoryBot.define do
  factory :review do
    content { Faker::Lorem.sentences }

    association :user
    association :manual
  end
end
