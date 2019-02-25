class Item

    class << self

    def initialize (options)
      options[:host] = '127.0.0.1'
         @items =Item.new(options)
      @table_name = class_name
    end

    def create_table
      query = "CREATE TABLE #{@table_name} (id INTEGER PRIMARY KEY, name VARCHAR(50), price VARCHAR(50), weight VARCHAR(50));"
      @items.qr(query)
    end

    def create(items)
        prepare_insert
        @items.qr.prepare_insert('insert_items', [items[0],items[1]])
    end


    def read_all
           items = Array.new
           @items.qr("SELECT * FROM #{@table_name}") do |result|
            i = result.count - 1
            while i >= 0
           items << result[i]
            i -= 1
          end
        end
        p items
    end

    def update(items)
      @items.qr("UPDATE Item SET #{items[:name]} = '#{items[:new_name]}' WHERE #{items[:name]} = '#{items[:old_name]}';")
    end

    def destroy(element)
      @items.qr("DELETE FROM #{@table_name} WHERE #{element[:name]} = '#{element[:value]}'")
    end

    def delete_table
      @items.qr("DROP TABLE IF EXISTS #{@table_name}")
    end

    def close_connection
      @items.close
    end

      def select_all
        items = Array.new
        @items.qr("SELECT * FROM #{@table_name}") do |result|
          i = result.count - 1
          while i >= 0
           items << result[i]
            i -= 1
          end
        end
        p items
      end

      def get_table_fields
        fields = Array.new
        str = ''
        count = 0
        @items.qr("SELECT column_name
                   FROM INFORMATION_SCHEMA.COLUMNS
                   WHERE table_name = '#{@table_name}';") do |result|
          i = result.count - 1
          count = i+1
          while i >= 0
            if i > 0
              str += result[i]['column_name'] + ','
              i -= 1


            else
              str += result[i]['column_name']
              i -=1
            end
          end
        end
        fields[0] = str
        fields[1] = count
        fields
      end

      def class_name
        self.name.to_s.downcase + 's'
      end

      def prepare_insert
        fields = get_table_fields
        str = ' '
        i =1
        while i <= fields[1]
          if i == fields[1]
            str += "$#{i})"
            i += 1
          else
            str+= "($#{i}, "
            i += 1
          end
        end
        @items.insert('insert_items', "INSERT INTO #{@table_name} (#{fields[0]}) prices #{str});")
     
     end
    end
end