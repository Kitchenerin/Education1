#require_relative 'users'
#require_relative 'cars'
require_relative 'base_classes'
require_relative 'operation'
user = Users.new
con = Users.open_connection
puts "What would you like do? Options: (create)(read)(update)(select)(delete)"
choice = gets.chomp
case choice

  when "create"
    puts "Enter id byers:"
    id = gets.chomp
    puts "Enter name byers:"
    name = gets.chomp
    puts "Enter family_name byers:"
    family_name = gets.chomp
    puts "Enter phone_number byers:"
    phone_number = gets.chomp
    Bases.add( id: id, name: name, family_name: family_name, phone_number: phone_number)
    puts "Record #{id} is added"
    Bases.show

  when "select"
    puts "Enter id byers:"
    id = gets.chomp
    puts "Enter name byers:"
    name = gets.chomp
    puts "Enter family_name byers:"
    family_name = gets.chomp
    puts "Enter phone_number byers:"
    phone_number = gets.chomp
    Bases.select(con, id: id, name: name, family_name: family_name, phone_number: phone_number)
    Bases.show
    user.close(con)

  when "update"
    puts "Enter id byers:"
    id = gets.chomp
    puts "Enter name byers:"
    name = gets.chomp
    puts "Enter family_name byers:"
    family_name = gets.chomp
    puts "Enter phone_number byers:"
    phone_number = gets.chomp
    Bases.update(:id => id,:name => name, :family_name => family_name, :phone_number => phone_number)
    Bases.show
    user.close(con)

  when "read"
    puts "Enter id byers:"
    id = gets.chomp
    puts "Enter name byers:"
    name = gets.chomp
    puts "Enter family_name byers:"
    family_name = gets.chomp
    puts "Enter phone_number byers:"
    phone_number = gets.chomp
    puts "Query result:"
    user.where(con, id: id, name: name, family_name: family_name, phone_number: phone_number)
    user.show
    #user.close(con)

  when "delete"
    puts "Enter id byers:"
    id = gets.chomp
    Bases.destroy(id: id)
    puts "Record #{id} is removed"
    Bases.show
    user.close(con)
end