json.(food, :id, :name, :amount_of_sugar, :category_id)
json.category_name do
  food.category_id
end
