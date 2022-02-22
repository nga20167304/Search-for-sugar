json.total_pages @foods.total_pages
json.foods do
  json.array! @foods do |food|
    json.partial! 'shared/food', food: food
  end
end
