require_relative '../models/meal.rb'
require_relative 'base_repository.rb'
require 'csv'

class MealRepository < BaseRepository
  private

  def save_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }

    CSV.open(@csv_file, 'wb', csv_options) do |csv|
      csv << ['id', 'name', 'price']
      @elements.each do |element|
        csv << [element.id, element.name, element.price]
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
      @elements << meal
    end
  end
end