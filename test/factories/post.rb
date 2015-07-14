FactoryGirl.define do
  factory :post do
    author_id "1"
    board_id "1"
    sequence(:title) { |i| "Post Title #{i}"}
    sequence(:body) { |i| "Post Body #{i}"}
  end
end