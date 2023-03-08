require 'spec_helper'

RSpec.describe FoodTruck do
  describe '#initialize' do
    it 'exists and has attributes' do
      food_truck = FoodTruck.new("Rocky Mountain Pies")

      expect(food_truck).to be_a(FoodTruck)
      expect(food_truck.name).to eq('Rocky Mountain Pies')
    end
  end
end