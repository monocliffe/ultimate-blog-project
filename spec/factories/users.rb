FactoryBot.define do
  factory :user do
    forename { Faker::Name.first_name }
    surname  { Faker::Name.last_name }
    email    { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end