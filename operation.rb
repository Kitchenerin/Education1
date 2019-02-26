require 'pg'
require_relative 'base_classes'
class Users

DB_NAME = 'Byers'
DB_USER = 'user'
TABLE_NAME = 'byers'

	def create(id, name, family_name, phone_number)

		@user = User.create(id: id, name: name, family_name: family_name, phone_number: phone_number)

	end


	def self.open_connection
		PG.connect :dbname => DB_NAME , :user => DB_USER
	end
	
	def find(con, family_name, name, phone_number)
		@find = con.exec "SELECT * FROM #{TABLE_NAME} WHERE family_name = '#{family_name}'"
		@find = con.exec "SELECT * FROM #{TABLE_NAME} WHERE name = '#{name}'"
		@find = con.exec "SELECT * FROM #{TABLE_NAME} WHERE phone_number = '#{phone_number}'"
	end
	
	def where(con, options={})	
		query = "SELECT * FROM #{TABLE_NAME} WHERE"
		options.each{ | k,v |
		query = query << " #{k}" << " = " << "'#{v}'" << " or" } 
		@find = con.exec "#{query.chomp("or")}"
	end

	def save
		@user = User.new
		@user.save
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
