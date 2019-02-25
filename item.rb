class Item

  class << self

    def initialize (options) 
         @connection = Connection.new(options)
    end

    def create_table
      query = "CREATE TABLE items (id INTEGER PRIMARY KEY, name VARCHAR(50), price VARCHAR(50), weight VARCHAR(50));"
      @connection_query(query)
    end

    def create(items)
        prepare_insert
        @connection.query_prepared("insert_items", [items[0],items[1]])
    end

    def read_all
           items = Array.new
           @connection.query("SELECT * FROM items") do |result|
            i = result.count - 1
            while (i >= 0)
           items << result[i]
            i -= 1
          end
        end
        p items
    end

    def update(items)
      @connection_query("UPDATE Item SET #{items[:name]} = '#{items[:new_name]}' WHERE #{items[:name]} = '#{items[:old_name]}';")
    end

    def destroy(object)
      @connection_query("DELETE FROM items WHERE #{object [:name]} = '#{object [:value]}'")
    end

    def delete_table
      @connection_query("DROP TABLE IF EXISTS items")
    end

    def close_connection
      @connection.close
    end

    def select_all
        items = Array.new
        @connection.query("SELECT * FROM items") do |result|
          i = result.count - 1
          while (i >= 0)
           items << result[i]
            i -= 1
          end
        end
        p items
      end

      def get_table
        fields = Array.new
        str = ""
        count = 0
        @connection.query("SELECT column_name
                   FROM INFORMATION_SCHEMA.COLUMNS
                   WHERE items = 'items';") do |result|
          i = result.count - 1
          count = i+1
          while (i >= 0)
            if (i > 0)
              str += result[i]["column_name"] + ", "
              i -= 1


            else
              str += result[i]["column_name"]
              i -=1
            end
          end
        end
        fields[0] = str
        fields[1] = count
        return fields
      end

      def class_name
        self.name.to_s.downcase + "s"
      end

      def insert
        fields = get_table_fields
        str = ""
        i =1
        while i <= fields[1]
          unless i == fields[1]
            str+= "($#{i}, "
            i += 1
          else
            str += "$#{i})"
            i += 1
          end
        end
        @connection.insert("insert_items", "INSERT INTO items (#{fields[0]}) prices #{str});")
     
     end
end  