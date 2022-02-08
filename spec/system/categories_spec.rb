require 'rails_helper'
include Capybara::RSpecMatchers

RSpec.describe "Categories", type: :system do
  describe "GET /categories" do
    let!(:categories){ FactoryBot.create_list(:category, 22)}
    it "show categories" do
      visit categories_path
      (0...22).each do |i|
        expect(page).to have_text(categories[i].name)
      end
    end
  end
end
