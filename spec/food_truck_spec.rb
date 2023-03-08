require 'spec_helper'

RSpec.describe FoodTruck do
  before(:each) do
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @food_truck = FoodTruck.new("Rocky Mountain Pies")
  end

  describe '#initialize' do
    it 'exists and has attributes' do
      expect(@food_truck).to be_a(FoodTruck)
      expect(@food_truck.name).to eq('Rocky Mountain Pies')
    end
  end

  describe '#stock/check_stock' do
    it 'starts with no stock' do 
      expect(@food_truck.inventory).to eq({})
      expect(@food_truck.check_stock(@item1)).to eq(0)
    end

    it 'can stock items' do
      @food_truck.stock(@item1, 30)

      expect(@food_truck.inventory).to eq({ @item1 => 30 })
      expect(@food_truck.check_stock(@item1)).to eq(30)
    end

    it 'can stock more items' do
      @food_truck.stock(@item1, 30)
      @food_truck.stock(@item1, 25)

      expect(@food_truck.check_stock(@item1)).to eq(55)

      @food_truck.stock(@item2, 12)
      expect(@food_truck.inventory).to eq({ @item1 => 30, @item2 => 12 })
    end
  end
end