require_relative "../views/customers_view.rb"

class CustomersController
  def initialize(customer_repository)
    @customer_repo = customer_repository
    @view = CustomersView.new
  end

  def list
    customers = @customer_repo.all
    @view.display(customers)
  end

  def add
    name, address = @view.ask_customer
    customer = Customer.new(name: name, address: address)
    @customer_repo.create(customer)
  end
end