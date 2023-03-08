require 'spec_helper'

RSpec.describe Item do
  describe '#initialize' do
    it 'exists and has attributes' do
      item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})

      expect(item2).to be_a(Item)
      expect(item2.name).to eq("Apple Pie (Slice)")
      expect(item2.price).to eq(2.50)
    end
  end
end