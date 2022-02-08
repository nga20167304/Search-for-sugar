require 'rails_helper'

RSpec.describe Category, type: :model do
  context "Associations" do
    it "should has many foods" do
      association = described_class.reflect_on_association(:foods)
      expect(association.macro).to eq :has_many
    end
  end
end
