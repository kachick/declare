$VERBOSE = true


class Person
  
  attr_reader :name, :birth
  
  def initialize(name)
    @name = name
    @birth = Time.now
  end

end

require '../lib/declare'

Declare do
  
  The Person.new('John') do

    respond :name
    respond :birth
    a Person
    kind Object
    
    NOT 'Taro'
    
    The it.name do
      
      kind String
  
    end

    The it.birth do
      
      kind Time
      
    end

    truthy it.name.kind_of?(String)
    falthy it.name.match(/[1-9]/)
  
    The it.name do
      
      is 'Taro'
    
    end
    
    
  end
  
end

=begin
Below definitions are not satisfied some conditions.
====================================================
### "John" ### [mixed.rb:43]
  * "It's euqualy value with "Taro" under bidirectical #== method.", but MISMATCHED. [mixed.rb:45]

----------------------------------------------------------------------------
1 categorizies, 4 scopes, 10 behaviors
    pass: 9
    fail: 1
=end

