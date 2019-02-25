require 'pg'

class Users

DB_NAME = 'Byers'
DB_USER = 'user'
TABLE_NAME = 'byers'

	def self.open_connection
		PG.connect :dbname => DB_NAME , :user => DB_USER
	end
	
	def find(con, name)
		@find = con.exec "SELECT * FROM #{TABLE_NAME} WHERE name = '#{name}'" 
	end
	
	def where(con, options={})	
		query = "SELECT * FROM #{TABLE_NAME} WHERE"
		options.each{ | k,v |
		query = query << " #{k}" << " = " << "'#{v}'" << " or" } 
		@find = con.exec "#{query.chomp("or")}"
	end

	def show_results
		@find.each do |row|
			p row
		end
		
	end

	def close(con)
		con.close
	end

end

user = Users.new
con = Users.open_connection
name = gets.chomp
user.where(con, name: name, phone_number: '')
user.show_results
user.close(con)