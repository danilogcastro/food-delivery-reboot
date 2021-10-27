# TODO: implement the router of your app.
class Router
  def initialize(meals_controller, customers_controller, sessions_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @running = true
  end

  def run
    puts "------------------------"
    puts "Welcome to Food Delivery"
    puts "------------------------"
    @employee = @sessions_controller.login
    while @running
      if @employee.manager?
        display_manager_tasks
        puts "What do you want to do?"
        action = gets.chomp.to_i
        print `clear`
        route_to_manager(action)
      elsif @employee.rider?
        display_rider_tasks
        puts "What do you want to do?"
        action = gets.chomp.to_i
        print `clear`
        route_to_rider(action)
      end
    end
  end

  def route_to_manager(action)
    case action
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 3 then @customers_controller.list
    when 4 then @customers_controller.add
    when 5 then puts "TODO: add an order"
    when 6 then puts "TODO: list undelivered orders"
    when 7 then @running = false
    end
  end

  def display_manager_tasks
    puts "1 - List all meals"
    puts "2 - Create a meal"
    puts "3 - List all customers"
    puts "4 - Create a customer"
    puts "5 - Add an order"
    puts "6 - List undelivered orders"
    puts "7 - Exit"
  end

  def route_to_rider(action)
    case action
    when 1 then puts "TODO: mark order as delivered"
    when 2 then puts "TODO: list my undelivered orders"
    when 3 then @running = false
    end
  end

  def display_rider_tasks
    puts "1 - Mark order as delivered"
    puts "2 - List my undelivered orders"
    puts "3 - Exit"
  end
end