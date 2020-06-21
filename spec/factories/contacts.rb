FactoryBot.define do
  factory :contact do
    user_id { 1 }
    name { "MyString" }
    email { "MyString" }
    message { "MyString" }
  end
end
