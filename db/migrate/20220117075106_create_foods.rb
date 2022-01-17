class CreateFoods < ActiveRecord::Migration[6.1]
  def change
    create_table :foods do |t|
      t.string :name
      t.float :amount_of_sugar
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
