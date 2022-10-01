FactoryBot.define do
  factory :question do
    title { "MyString1" }
    body { "MyText1" }
    user

    trait :invalid do
      title { nil }
    end

    trait :with_comments do
      after(:create) do |question|
        create_list(:comment, 3, commentable: question)
      end
    end

    # trait :with_file do
    #   path = Rails.root.join('spec/1.txt')
    #   attachments { Rack::Test::UploadedFile.new(path, 'text/plain') }
    # end
  end
end
