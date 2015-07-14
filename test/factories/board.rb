FactoryGirl.define do
  factory :board do
    moderator_id "1"
    sequence(:name) { |i| "Board Title #{i}"}
  end
end