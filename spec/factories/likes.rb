FactoryBot.define do
  factory :like do
    association :user
    association :manual
  end
end
