class OrdersView
  def ask_order_info
    puts "What's the meal?"
    print "> "
    meal_index = gets.chomp.to_i
    puts "Who's the customer?"
    print "> "
    customer_index = gets.chomp.to_i
    puts "Who's the rider"
    print "> "
    rider_index = gets.chomp.to_i
    [meal_index, customer_index, rider_index]
  end

  def list(elements)
    elements.each_with_index do |element, index|
      puts "#{index + 1}- #{element.meal.name} - #{element.customer.name}"
    end
  end

  def ask_order
    puts "Which order?"
    print "> "
    index = gets.chomp.to_i
  end
end