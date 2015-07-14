FactoryGirl.define do
  factory :user, aliases: [:author, :moderator] do
    sequence(:email) { |i| "user#{i}@example.com" }
    password "password"
  end
end