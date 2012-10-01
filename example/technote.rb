$VERBOSE = true


class Person

  def initialize(name)
    @name = name
  end

end

require_relative '../lib/declare'
  
The Person do
  
  # This block is going to be evaluated in Declare::Scope
  # "it" is point to the "Person"

  The it.new('John') do
    
    # This block is going to be evaluated in Declare::Scope
    # "it" is point to the "John, who is instance of Person"
    
  end
  
end
