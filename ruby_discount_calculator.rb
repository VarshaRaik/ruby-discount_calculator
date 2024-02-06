class DiscountCalculator
    PRICE_TABLE = {
      "Milk" => { unit_price: 3.97, sale_price: 5.00, sale_quantity: 2 },
      "Bread" => { unit_price: 2.17, sale_price: 6.00, sale_quantity: 3 },
      "Banana" => { unit_price: 0.99 },
      "Apple" => { unit_price: 0.89 }
    }
  
    def initialize
      @items = Hash.new(0)
    end
  
    def price_calculation
      total_price = 0.0
      @items.each do |item, quantity|
        total_price += item_price_calculation(item, quantity)
      end
  
      total_price
    end
  
    def item_price_calculation(item, quantity)
      price_info = PRICE_TABLE[item]
      unit_price = price_info[:unit_price]
      sale_price = price_info[:sale_price]
      sale_quantity = price_info[:sale_quantity]
  
      if sale_price && quantity >= sale_quantity
        sale_price * (quantity / sale_quantity) + unit_price * (quantity % sale_quantity)
      else
        unit_price * quantity
      end
    end
  
    def display_receipt
      puts "Item     Quantity      Price"
      puts "--------------------------------------"
      @items.each do |item, quantity|
        price = item_price_calculation(item, quantity)
        puts "#{item.ljust(8)} #{quantity.to_s.ljust(12)} $#{'%.2f' % price}"
      end
      puts "\nTotal price : $#{'%.2f' % price_calculation}"
      puts "You saved $#{'%.2f' % (calculate_regular_price - price_calculation)} today."
    end
  
    def calculate_regular_price
      regular_price = 0.0
      @items.each do |item, quantity|
        price_info = PRICE_TABLE[item]
        regular_price += price_info[:unit_price] * quantity
      end
  
      regular_price
    end
  
    def run_all_actions
        puts "Please enter all the items purchased separated by a comma"
        input = gets.chomp.downcase
        items_array = input.split(",").map(&:strip)
    
        items_array.each do |item|
          capitalized_item = item.capitalize
          if PRICE_TABLE.key?(capitalized_item)
            @items[capitalized_item] += 1
          else
            puts "Error: #{item} is not a valid item."
          end
        end
  
      display_receipt
    end
  end
  
  discount_calculator = DiscountCalculator.new
  discount_calculator.run_all_actions
  