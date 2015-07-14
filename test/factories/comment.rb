FactoryGirl.define do
  factory :comment do
    author
    post
    body "Comment Body"
  end
end