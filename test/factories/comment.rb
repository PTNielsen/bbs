FactoryGirl.define do
  factory :comment 
    author_id "1"
    post_id "1"
    sequence(:body) { |i| "Comment #{i}" }
  end
end