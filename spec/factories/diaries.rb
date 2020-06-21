FactoryBot.define do
  factory :diary do
    title { Faker::Lorem.characters(number:5) }
    body { Faker::Lorem.characters(number:20) }
    image_id { "MyString" }
    user
  end
end
