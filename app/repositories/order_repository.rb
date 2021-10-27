require_relative '../models/order.rb'
require_relative 'base_repository.rb'
require 'csv'

class OrderRepository < BaseRepository
  attr_reader :elements

  def initialize(csv_file_path, meal_repository, customer_repository, employee_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    super(csv_file_path)
  end

  # def create(order)
  #   order.id = @next_id
  #   @elements << order
  #   @next_id += 1
  #   save_csv
  # end

  def undelivered_orders
    @elements.reject { |element| element.delivered? }
  end

  def update
    save_csv
  end

  private

  def save_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }

    CSV.open(@csv_file, 'wb', csv_options) do |csv|
      csv << ['id', 'meal_id', 'customer_id', 'employee_id', 'delivered']
      @elements.each do |element|
        csv << [element.id, element.meal.id, element.customer.id, element.employee.id, element.delivered?]
      end
    end
  end

  def load_csv
    csv_options = { col_sep: ',', quote_char: '"', headers: :first_row, header_converters: :symbol }

    CSV.foreach(@csv_file, csv_options) do |row|
      id = row[:id].to_i
      meal = @meal_repository.find(row[:meal_id].to_i)
      customer = @customer_repository.find(row[:customer_id].to_i)
      employee = @employee_repository.find(row[:employee_id].to_i)
      delivered = row[:delivered] == 'true'
      order = Order.new(id: id, meal: meal, 
                        customer: customer, 
                        employee: employee, 
                        delivered: delivered)
      @elements << order
    end
  end
end