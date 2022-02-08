require "rails_helper"

RSpec.describe "Foods System", :type => :system do
  let!(:category) do
    FactoryBot.create(:category)
  end

  let!(:food){ FactoryBot.create_list(:food, 10, category_id: category.id)}

  it "search" do
    visit root_path

    fill_in "q[name_cont]", :with => "food-1"
    click_button "検索"

    expect(page).to have_text("food-1")
    expect(page).to have_text("food-10")
    expect(page).not_to have_text("food-2")
  end
end
