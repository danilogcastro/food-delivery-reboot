require_relative '../models/customer.rb'
require_relative 'base_repository.rb'
require 'csv'

class CustomerRepository < BaseRepository
  private

  def save_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }

    CSV.open(@csv_file, 'wb', csv_options) do |csv|
      csv << ['id', 'name', 'address']
      @elements.each do |element|
        csv << [element.id, element.name, element.address]
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
      @elements << customer
    end
  end
end