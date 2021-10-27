require_relative "../views/sessions_view.rb"

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @view = SessionsView.new
  end

  def login
    username, password = @view.ask_credentials
    employee = @employee_repository.find_by_username(username)
    if employee && employee.password == password
      puts "Welcome, #{username}"
      employee
    else
      puts "Wrong credentials! Try again!"
      login
    end
  end
end