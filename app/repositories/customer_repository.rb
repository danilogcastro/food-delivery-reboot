require 'csv'
require_relative '../models/customer.rb'

class CustomerRepository
  def initialize(csv_file_path)
    @csv_file = csv_file_path
    @customers = []
    load_csv if File.exist?(@csv_file)
    @next_id = @customers.empty? ? 1 : @customers.last.id + 1
  end

  def all
    @customers
  end

  def create(customer)
    customer.id = @next_id
    @customers << customer
    @next_id += 1
    save_csv
  end

  def find(id)
    @customers[id - 1]
  end

  private

  def save_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }

    CSV.open(@csv_file, 'wb', csv_options) do |csv|
      csv << ['id', 'name', 'address']
      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end

  def load_csv
    csv_options = { col_sep: ',', quote_char: '"', headers: :first_row, header_converters: :symbol }

    CSV.foreach(@csv_file, csv_options) do |row|
      name = row[:name]
      address = row[:address]
      id = row[:id].to_i
      customer = Customer.new(id: id, name: name, address: address)
      @customers << customer
    end
  end
end