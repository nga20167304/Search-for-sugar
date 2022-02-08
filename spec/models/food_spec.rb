require 'rails_helper'

RSpec.describe Food, type: :model do
  context "Associations" do
    it "belongs to Category" do
      association = described_class.reflect_on_association(:category)
      expect(association.macro).to eq :belongs_to
    end
  end
end
