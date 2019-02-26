require_relative 'users'
require_relative 'cars'
require_relative 'base_classes'
require_relative 'operation'

con = Users.open_connection
id = gets.chomp
name = gets.chomp
family_name = gets.chomp
phone_number = gets.chomp
Base.add( id: id, name: name, family_name: family_name, phone_number: phone_number)
Users.save(id: id, name: name, family_name: family_name, phone_number: phone_number)
id = gets.chomp
name = gets.chomp
family_name = gets.chomp
phone_number = gets.chomp
Base.update(id: id, name: name,family_name: family_name, phone_number:phone_number)
Users.show_results
Users.close(con)
id = gets.chomp
name = gets.chomp
family_name = gets.chomp
phone_number = gets.chomp
user.where(con, id: id, name: name, family_name: family_name, phone_number: phone_number)
Users.show_results
Users.close(con)
id = gets.chomp
Base.destroy(id: id)
Users.show_results
Users.close(con)
