require './item_updater.rb'
require 'minitest/autorun'
require 'redgreen'

describe ItemUpdater do

  def update_item(item_config)
    @item = Item.new(item_config[:name], item_config[:sell_in], item_config[:quality])
    ItemUpdater.new.update(@item)
  end

  it "decreases sell by on update" do
    update_item sell_in: 5, quality: 10

    assert_equal 4, @item.sell_in
  end

  it "decreases quality value by one every day" do
    update_item sell_in: 5, quality: 10

    assert_equal 9, @item.quality
  end

  it "Once the sell by date has passed, Quality degrades twice as fast" do
    update_item sell_in: -1, quality: 10

    assert_equal 8, @item.quality
  end

  it "The Quality of an item is never negative" do
    update_item sell_in: 1, quality: 0

    assert_equal 0, @item.quality
  end

  it "Aged Brie actually increases in Quality the older it gets" do
    update_item name: 'Aged Brie', sell_in: 10, quality: 2

    assert_equal 3, @item.quality
  end

  it "The Quality of an item is never more than 50" do
    update_item name: 'Aged Brie', sell_in: 10, quality: 50

    assert_equal 50, @item.quality
  end

  it "Sulfuras, being a legendary item, never has to be sold or decreases in Quality" do
    update_item name: 'Sulfuras', sell_in: 0, quality: 50

    assert_equal 50, @item.quality
    assert_equal 0, @item.sell_in
  end
end
