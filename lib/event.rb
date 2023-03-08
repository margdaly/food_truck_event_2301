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
    all_items.map do |item|
      item_details = [['quantity', total_quantity(item)], ['food_trucks', food_trucks_that_sell(item)]].to_h
      [item, item_details]
    end.to_h
  end

  def overstocked_items
    all_items.select do |item|
      food_trucks_that_sell(item).count > 1 && total_quantity(item) > 50
    end
  end

  def sell(item, amount)
    return false if total_quantity(item) < amount
    @food_trucks.find do |food_truck|
      if food_truck.inventory.key?(item)
        food_truck.inventory[item] -= amount
        break if food_truck.inventory[item] == 0
      end
    end
    true
  end
end
