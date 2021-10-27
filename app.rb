# TODO: require relevant files to bootstrap the app.
# Then you can test your program with:
#   ruby app.rb
require_relative 'router'
require_relative "app/repositories/meal_repository.rb"
require_relative "app/repositories/customer_repository.rb"
require_relative "app/repositories/employee_repository.rb"
require_relative "app/controllers/customers_controller.rb"
require_relative "app/controllers/meals_controller.rb"
require_relative "app/controllers/sessions_controller.rb"

meals_repo = MealRepository.new("data/meals.csv")
meals_controller = MealsController.new(meals_repo)

customers_repo = CustomerRepository.new("data/customer.csv")
customers_controller = CustomersController.new(customers_repo)

employee_repo = EmployeeRepository.new("data/employees.csv")
sessions_controller = SessionsController.new(employee_repo)

router = Router.new(meals_controller, customers_controller, sessions_controller)
router.run