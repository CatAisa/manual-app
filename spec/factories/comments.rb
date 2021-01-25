FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.sentences }

    association :user
    association :manual
    association :procedure
  end
end
