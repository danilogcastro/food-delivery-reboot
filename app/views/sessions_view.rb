class SessionsView
  def ask_credentials
    puts "Username?"
    print "> "
    username = gets.chomp
    puts "Password?"
    print "> "
    password = gets.chomp
    [username, password]
  end
end