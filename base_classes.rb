require 'pg'
require_relative 'operation'
class Base

DB_NAME = 'Byers'
DB_USER = 'user'
@table_name = 'byers'

	class << self

		def connection
			PG.connect :dbname => DB_NAME , :user => DB_USER
		end

		def add(**options)
			query = "INSERT INTO #{@table_name} VALUES("
			options.each{ |k,v| 
				query = query << "'#{v}'" <<','}
			query = query.chomp(",")
			connection.exec "#{query<<')'}"
			close_connection

		end

		def save (id, name, family_name, phone_number)
			@base = Base.new(id: id, name: name, family_name: family_name, phone_number: phone_number)
			@base.save
		end

		def select(logic_operation=nil, **options)
			query = "SELECT * FROM #{@table_name} WHERE"
			options.each{ | k,v |
				query = query << " #{k}" << " = " << "'#{v}'" << " #{logic_operation}" }
			query = query.chomp(logic_operation)
			connection.exec "#{query}"
			close_connection		
		end

		def update(name,family_name,phone_number, **options )
			query = "UPDATE #{@table_name} SET "
			options.each{ | k,v |
				query = query << " #{k}" << " = " << "'#{v}'" << " , " }
			query = query.chomp(' , ')
			query = query << "WHERE "<< "name ='#{name}'"
			connection.exec "#{query}"
			close_connection

		end

		def destroy(**options)
			query = "DELETE FROM #{@table_name} WHERE"
			options.each{ | k,v |
				query = query << " #{k}" << " = " << "'#{v}'"}
			response = connection.exec "#{query}"
			close_connection
		end
		
		def close_connection
			connection.close
		end

	def table_name
		self.name << 's'
	end
	end
end