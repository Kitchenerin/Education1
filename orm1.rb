require "pg"
	require_relative "item"
	require_relative "order"


	options = {:user => "Kitchenerin", :password => "7286", :dbname => "items"}



	array = Array.new
	array[1] = 1
	array[0] = "name1"


	items_to_update = {:name => "name", :old_value => "name1", :new_value => "name2"}
	items_to_del = {:name => "name", :value => "new2"}

	Order.initialize(options)
	Order.create(array)
	Order.read_all
	Order.update(items_to_update)
	Order.read_all
	Order.delete(items_to_del)
	Order.read_all
	Order.close_connection
