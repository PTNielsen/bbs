FactoryGirl.define do
  factory :post do
    author
    board
    title "Post Title"
    body "Post Body"
  end
end