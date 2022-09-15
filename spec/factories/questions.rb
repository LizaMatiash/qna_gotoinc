FactoryBot.define do
  factory :question do
    title { "MyString1" }
    body { "MyText1" }
    user

    trait :invalid do
      title { nil }
    end
  end
end
