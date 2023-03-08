require 'spec_helper'

RSpec.describe Event do
  before(:each) do
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    @food_truck1 = FoodTruck.new("Rocky Mountain Pies")
    @food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
    @food_truck3 = FoodTruck.new("Palisade Peach Shack")
    @event = Event.new("South Pearl Street Farmers Market")

    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)
    @food_truck2.stock(@item3, 25)
    @food_truck2.stock(@item4, 50)
    @food_truck3.stock(@item1, 65)
  end

  describe '#initialize' do
    it 'exists and has attributes' do
      expect(@event).to be_a(Event)
      expect(@event.name).to eq("South Pearl Street Farmers Market")
    end
  end

  describe '#food_trucks' do
    it 'starts with no food_trucks' do
      expect(@event.food_trucks).to eq([])
    end

    it 'can add_food_trucks' do
      @event.add_food_truck(@food_truck1)
      expect(@event.food_trucks).to eq([@food_truck1])

      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)
      expect(@event.food_trucks).to eq([@food_truck1, @food_truck2, @food_truck3])
    end

    it 'can list all #food_trucks_names' do
      @event.add_food_truck(@food_truck1)
      expect(@event.food_trucks_names).to eq(['Rocky Mountain Pies'])

      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)
      expect(@event.food_trucks_names).to eq(["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end

    it 'can list #food_trucks_that_sell given item' do
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck2)
      
      expect(@event.food_trucks_that_sell(@item1)).to eq([@food_truck1])
      expect(@event.food_trucks_that_sell(@item4)).to eq([@food_truck2])
      
      @event.add_food_truck(@food_truck3)
      expect(@event.food_trucks_that_sell(@item1)).to eq([@food_truck1, @food_truck3])
    end
  end

  describe '#overstocked_items' do
    xit 'can list items sold by more than 1 food truck AND total quantity greater than 50' do
      @event.add_food_truck(@food_truck1)
      expect(@event.overstocked_items).to eq([])

      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)
      expect(@event.overstocked_items).to eq([@item1])

      @food_truck2.stock(@item4, 10)
      expect(@event.overstocked_items).to eq([@item1, @item4])
    end
  end

  describe '#all_items' do
    it 'can list all items sold by food_trucks without duplicates' do
      @event.add_food_truck(@food_truck1)
      expect(@event.all_items).to eq([@item1, @item2])

      @event.add_food_truck(@food_truck2)
      expect(@event.all_items).to eq([@item1, @item2, @item3, @item4])

      @event.add_food_truck(@food_truck3)
      expect(@event.all_items).to eq([@item1, @item2, @item3, @item4])
    end
  end

  describe '#sorted_items_list' do
    it 'can list names of all items FoodTrucks have in stock, sorted alphabetically' do
      @event.add_food_truck(@food_truck1)
      expect(@event.sorted_items_list).to eq(['Apple Pie (Slice)', 'Peach Pie (Slice)'])

      @event.add_food_truck(@food_truck2)
      expect(@event.sorted_items_list).to eq(['Apple Pie (Slice)', 'Banana Nice Cream','Peach Pie (Slice)', 'Peach-Raspberry Nice Cream'])

      @event.add_food_truck(@food_truck3)
      expect(@event.sorted_items_list).to eq(['Apple Pie (Slice)', 'Banana Nice Cream','Peach Pie (Slice)', 'Peach-Raspberry Nice Cream'])
    end
  end

  describe '#total_inventory' do
    it 'returns list of quantities of all items sold at the event' do
      @event.add_food_truck(@food_truck1)
      expect(@event.total_inventory).to eq({
        @item1 => { 'quantity' => 35, 'food_trucks' => [@food_truck1] },
        @item2 => { 'quantity' => 7, 'food_trucks' => [@food_truck1] }
      })

      @event.add_food_truck(@food_truck2)
      expect(@event.total_inventory).to eq({
        @item1 => { 'quantity' => 35, 'food_trucks' => [@food_truck1] },
        @item2 => { 'quantity' => 7, 'food_trucks' => [@food_truck1] },
        @item3 => { 'quantity' => 25, 'food_trucks' => [@food_truck2] },
        @item4 => { 'quantity' => 50, 'food_trucks' => [@food_truck2] }
      })

      @event.add_food_truck(@food_truck3)
      expect(@event.total_inventory).to eq({
        @item1 => { 'quantity' => 100, 'food_trucks' => [@food_truck1, @food_truck3] },
        @item2 => { 'quantity' => 7, 'food_trucks' => [@food_truck1] },
        @item3 => { 'quantity' => 25, 'food_trucks' => [@food_truck2] },
        @item4 => { 'quantity' => 50, 'food_trucks' => [@food_truck2] }
      })
    end
  end

  describe '#total_quantity' do
    it 'can calculate total quantity of an item' do
      @event.add_food_truck(@food_truck1)
      expect(@event.total_quantity(@item1)).to eq(35)

      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)

      expect(@event.total_quantity(@item4)).to eq(50)
      expect(@event.total_quantity(@item1)).to eq(100)
    end
  end
end