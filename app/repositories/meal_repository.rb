require_relative '../models/meal.rb'
require 'csv'

class MealRepository
  def initialize(csv_file_path)
    @csv_file = csv_file_path
    @meals = []
    load_csv if File.exist?(@csv_file)
    @next_id = @meals.empty? ? 1 : @meals.last.id + 1
  end

  def all
    @meals
  end

  def create(meal)
    meal.id = @next_id
    @meals << meal
    @next_id += 1
    save_csv
  end

  def find(id)
    @meals[id - 1]
  end

  private

  def save_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }

    CSV.open(@csv_file, 'wb', csv_options) do |csv|
      csv << ['id', 'name', 'price']
      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end

  def load_csv
    csv_options = { col_sep: ',', quote_char: '"', headers: :first_row, header_converters: :symbol }

    CSV.foreach(@csv_file, csv_options) do |row|
      name = row[:name]
      price = row[:price].to_i
      id = row[:id].to_i
      meal = Meal.new(id: id, name: name, price: price)
      @meals << meal
    end
  end
end