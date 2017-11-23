require 'rails_helper'

RSpec.describe Item, type: :model do
  context "validations" do
    it {should validate_presence_of(:name)}
  end

  context "relationships" do
    it {should belong_to(:todo)}
  end
end
