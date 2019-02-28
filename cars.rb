require_relative 'base_classes'

class Car < Bases
  def initialize(find = 'name', user = 'username', query = 'query')
  super(find,user,query)
    @names  = names
  end
end