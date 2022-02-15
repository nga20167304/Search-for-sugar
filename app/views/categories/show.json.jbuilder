json.array! @foods do |food|
  json.partial! 'shared/food', food: food
end
