FactoryBot.define do
  factory :release do
    association :user
    association :manual
  end
end
