class FoodTruck
  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def check_stock(item)
    return 0 if !@inventory.include?(item)

    @inventory[item]
  end

  def stock (item, amount)
    @inventory[item] += amount
  end
end
