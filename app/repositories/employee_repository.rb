require_relative '../models/employee.rb'
require_relative 'base_repository.rb'
require 'csv'

class EmployeeRepository < BaseRepository

  def all_riders
    @elements.select { |employee| employee.rider? }
  end

  def find_by_username(username)
    @elements.find { |employee| employee.username == username }
  end

  private

  def load_csv
    csv_options = { col_sep: ',', quote_char: '"', headers: :first_row, header_converters: :symbol }

    CSV.foreach(@csv_file, csv_options) do |row|
      username = row[:username]
      password = row[:password]
      role = row[:role]
      id = row[:id].to_i
      employee = Employee.new(id: id, username: username, password: password, role: role)
      @elements << employee
    end
  end
end