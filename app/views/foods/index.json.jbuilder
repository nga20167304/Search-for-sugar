json.array! @foods do |food|
  json.partial! 'foods/food', food: food
end
