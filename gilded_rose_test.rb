require './item_updater.rb'
require 'minitest/autorun'
require 'redgreen'

describe ItemUpdater do

  it "decreases sell by on update" do
    @item = Item.new("foo", 5, 10)
    ItemUpdater.new.update(@item)
    assert_equal 4, @item.sell_in
  end

  it "decreases quality value by one every day" do
    @item = Item.new("foo", 5, 10)
    ItemUpdater.new.update(@item)
    assert_equal 9, @item.quality
  end

  it "Once the sell by date has passed, Quality degrades twice as fast" do
    @item = Item.new("foo", -1, 10)
    ItemUpdater.new.update(@item)
    assert_equal 8, @item.quality
  end

  it "The Quality of an item is never negative" do
    @item = Item.new("foo", 1, 2)
    ItemUpdater.new.update(@item)
    ItemUpdater.new.update(@item)

    assert_equal 0, @item.quality
  end

  it "Aged Brie actually increases in Quality the older it gets" do
    @item = Item.new("Aged Brie", 10, 2)
    ItemUpdater.new.update(@item)

    assert_equal 3, @item.quality
  end

  it "The Quality of an item is never more than 50" do
    @item = Item.new("Aged Brie", 10, 50)
    ItemUpdater.new.update(@item)

    assert_equal 50, @item.quality
  end

  it "Sulfuras, being a legendary item, never has to be sold or decreases in Quality" do
    @item = Item.new("Sulfuras", 0, 50)
    ItemUpdater.new.update(@item)

    assert_equal 50, @item.quality
    assert_equal 0, @item.sell_in
  end

end
