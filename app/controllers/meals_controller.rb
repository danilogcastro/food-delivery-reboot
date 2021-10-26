require_relative "../views/meals_view.rb"

class MealsController
  def initialize(meal_repository)
    @meal_repo = meal_repository
    @view = MealsView.new
  end

  def list
    meals = @meal_repo.all
    @view.display(meals)
  end

  def add
    name, price = @view.ask_meal
    meal = Meal.new(name: name, price: price)
    @meal_repo.create(meal)
  end
end