FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number:10) }
    postal_code { 5998241 }
    prefecture_code { "大阪府" }
    city { "大阪市西成区"}
    street { "234" }
    email { Faker::Internet.email }
    introduction { Faker::Lorem.characters(number:20) }
    password { 'password' }
    password_confirmation { 'password' }

  end
end
