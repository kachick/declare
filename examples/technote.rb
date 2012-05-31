$VERBOSE = true


class Person

  def initialize(name)
    @name = name
  end

end

require '../lib/declare'

Declare do   # start to declare with categorizing text or nothing with :)
  
  # This block is going to be evaluated in Declare::DSL::Basic
  # "it" was undefined
  
  The Person do
    
    # This block is going to be evaluated in Declare::DSL::Scope
    # "it" is point to the "Person class"

    The it.new('John') do
    
      # This block is going to be evaluated in Declare::DSL::Scope
      # "it" is point to the "John"

    end
    
  end
  
end
