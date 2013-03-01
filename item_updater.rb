require './item.rb'

class ItemUpdater
  def update(item)
    return if item.name == "Sulfuras"

    decrease_sell_in(item)

    if item.name == 'Aged Brie'
      increase_quality(item)
    else
      decrease_quality(item)
    end

    item.quality = 0 if item.quality < 0
    item.quality = 50 if item.quality > 50
  end

  def decrease_quality(item)
    if item.sell_in < 0
      item.quality -= 2
    else
      item.quality -= 1
    end
  end

  def increase_quality(item)
    item.quality += 1
  end

  def decrease_sell_in(item)
    item.sell_in -= 1
  end
end
