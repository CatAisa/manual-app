FactoryBot.define do
  factory :user do
    nickname { 'abcde12345' }
    email { Faker::Internet.free_email }
    password { 'abcd1234' }
    password_confirmation { password }
  end
end
