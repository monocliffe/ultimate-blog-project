FactoryBot.define do
  factory :post do
    title { Faker::Lorem.word }
    body  { Faker::Lorem.paragraphs(number: 3) }
    user  { FactoryBot.create(:user) }
  end
end