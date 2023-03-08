class Event
  attr_reader :name, :food_trucks

  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(food_truck)
    @food_trucks << food_truck
  end

  def food_trucks_names
    @food_trucks.map { |food_truck| food_truck.name }
  end

  def food_trucks_that_sell(item)
    @food_trucks.select { |food_truck| food_truck.inventory.key?(item) }
  end

  def all_items
    @food_trucks.map do |food_truck|
      food_truck.inventory.keys
    end.flatten.uniq
  end

  def sorted_items_list
    all_items.map do |item|
      item.name
    end.sort
  end

  def total_quantity(item)
    food_trucks.map do |food_truck|
      food_truck.inventory[item] 
    end.sum
  end

  def total_inventory
    #{item => {'quantity' => total_quantity, 'food_trucks' => [food_trucks_that_sell_item]}}
    #item = [['quantity', total_quantity], ['foodtrucks', foodtrucks_that_sell]].to_h
    all_items.map do |item|
      item_details = ['quantity', ]
    end
  end

  # def overstocked_items
    
  # end
end
