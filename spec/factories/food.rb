FactoryBot.define do
  factory :food do
    category
    sequence(:name) { |n| "food-#{n}" }
    sequence(:amount_of_sugar) { |n| "#{n}"}
  end
end
