require './item.rb'

class ItemUpdater
  def update(item)
    return if item.name == "Sulfuras"

    item.sell_in -= 1
    if item.name == 'Aged Brie'
      item.quality += 1
    else
      if item.sell_in < 0
        item.quality -= 2
      else
        item.quality -= 1
      end
    end

    item.quality = 0 if item.quality < 0
    item.quality = 50 if item.quality > 50
  end
end
