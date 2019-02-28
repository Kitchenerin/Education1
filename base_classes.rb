require 'pg'
class Bases

  rowId = ARGV[0]

  DB_NAME = 'Byers'
  DB_USER = 'user'
  @table_name = 'byers'

  class << self

    def initialize(id = 'id', name = 'name', family_name = 'family_name', phone_number = 'phone_number')
        @id = id
        @name = name
        @family_name = family_name
        @phone_number = phone_number
    end

    def connection
      PG.connect :dbname => DB_NAME, :user => DB_USER
    end

    def add(**options)
      @query = "INSERT INTO #{@table_name} VALUES("
      options.each { |k, v|
        @query = @query << "'#{v}'" <<',' }
      @query = @query.chomp(",")
      connection.exec "#{@query<<')'}"
      close_connection
    end

    def save (id, name, family_name, phone_number)
      @base = Bases.new(id: id, name: name, family_name: family_name, phone_number: phone_number)
      @base.save
    end

    def select(logic_operation=nil, **options)
      #@query = "SELECT * FROM #{@table_name} WHERE"
      names = ["SELECT * FROM #{@table_name} WHERE"]
      options.each { |k, v|
        @query = @query << " #{k}" << " = " << "'#{v}'" << " #{logic_operation}" }
      #@query = query.chomp(logic_operation)
      connection.exec "#{@query}"
      close_connection
    end

    def update(name, **options)
      @query = "UPDATE #{@table_name} SET #{@changedName}= "
      rs = connection.exec "SELECT ARRAY(SELECT name FROM #{@table_name} LIMIT 3)"
      rs.each do |row|
        puts row
      end
      @changedName = rs[1]
      options.each { |k, v| @query = @query << " #{k}" << " = " << "'#{v}'" }
      @query = @query.chomp(' , ')
      @query = @query << "WHERE "<< "id = '#{id}'"
      connection.exec "#{@query}"
      close_connection
    end

    def destroy(**options)
      query = "DELETE FROM #{@table_name} WHERE"
      options.each { |k, v|
        query = query << " #{k}" << " = " << "'#{v}'" }
      response = connection.exec "#{query}"
      close_connection
    end

    def close_connection
      connection.close
    end

    def table_name
      self.name << 's'
    end

    def show
      connection.exec.each do |row|
        puts "%s %s %s" % [row['id'], row['name'], row['family_name'], row['phone_number']]
      end

    end
  end
end

class Car < Bases
  def initialize(id = '#{id}', name = '#{name}', family_name = '#{family_name}', phone_number = '#{phone_number}')
    super(id,name,family_name,phone_number)
  end
end