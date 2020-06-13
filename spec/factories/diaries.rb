FactoryBot.define do
  factory :diary do
    user_id { 1 }
    title { "MyString" }
    body { "MyText" }
    image_id { "MyString" }
  end
end
