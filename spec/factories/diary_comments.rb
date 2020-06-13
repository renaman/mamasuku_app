FactoryBot.define do
  factory :diary_comment do
    user_id { 1 }
    diary_id { 1 }
    comment { "MyText" }
  end
end
