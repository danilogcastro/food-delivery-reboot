require_relative '../views/orders_view'

class OrdersController
  def initialize(order_repository, meal_repository, customer_repository, employee_repository)
    @order_repo = order_repository
    @meal_repo = meal_repository
    @customer_repo = customer_repository
    @employee_repo = employee_repository
    @view = OrdersView.new
  end

  def add
    meal_index, customer_index, rider_index = @view.ask_order_info
    meal = @meal_repo.find(meal_index)
    customer = @customer_repo.find(customer_index)
    employee = @employee_repo.all_riders[rider_index - 1]
    order = Order.new(meal: meal, customer: customer, employee: employee)
    @order_repo.create(order)
  end

  def list_undelivered_orders
    undelivered_orders = @order_repo.undelivered_orders
    @view.list(undelivered_orders)
  end

  def mark_as_delivered(rider)
    orders = my_undelivered_orders(rider)
    index = @view.ask_order
    order = orders[index - 1]
    order.deliver!
    @order_repo.update
  end

  def my_undelivered_orders(rider)
    my_undelivered_orders = @order_repo.undelivered_orders.select { |order| order.employee == rider }
    @view.list(my_undelivered_orders)
    my_undelivered_orders
  end
end