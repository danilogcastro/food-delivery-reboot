class CustomersView
  def display(customers)
    customers.each_with_index do |customer, index|
      puts "#{index + 1} - #{customer.name} - #{customer.address}"
    end
  end

  def ask_customer
    puts "What is the name?"
    print "> "
    name = gets.chomp
    puts "What is the address?"
    print "> "
    address = gets.chomp
    [name, address]
  end
end