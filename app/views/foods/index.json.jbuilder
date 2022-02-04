json.array! @foods do |food|
  json.id food.id
  json.name food.name
  json.amount_of_sugar food.amount_of_sugar
  json.category_name food.category.name
end
