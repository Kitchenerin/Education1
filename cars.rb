require_relative 'base_classes'

class Car < Bases
  def initialize(id = '#{id}', name = '#{name}', family_name = '#{family_name}', phone_number = '#{phone_number}')
    @id = id
    @name = name
    @family_name = family_name
    @phone_number = phone_number
  end
end