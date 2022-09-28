FactoryBot.define do
  sequence :body do |n|
    "body_of_answer#{n}"
  end
  factory :answer do
    body
    question
    user

    trait :invalid do
      body { nil }
    end

    trait :with_comments do
      after(:create) do |answer|
        create_list(:comment, 3, commentable: answer)
      end
    end
  end
end
