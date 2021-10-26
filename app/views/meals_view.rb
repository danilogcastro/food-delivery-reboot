class MealsView
  def display(meals)
    meals.each_with_index do |meal, index|
      puts "#{index + 1} - #{meal.name} - #{meal.price}"
    end
  end

  def ask_meal
    puts "What is the name?"
    print "> "
    name = gets.chomp
    puts "What is the price?"
    print "> "
    price = gets.chomp.to_i
    [name, price]
  end
end