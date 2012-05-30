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
  
  on Person.new('John') do
    
    # OK section
    
    respond :name
    respond :birth
    a        Person
    kind     Object
    
    NOT 'Taro'
    
    on it.name do
      
      kind String
  
    end

    on it.birth do
      
      kind Time
      
    end

    truthy it.name.kind_of?(String)
    falthy it.name.match(/[1-9]/)
    
    # NG section
    
    on it.name do
      
      is 'Taro'
    
    end
    
    
  end
  
end

=begin
# Below points are not satisfied some conditions.

## "\"John\" (filename.rb:47)"
  * "It's euqualy value with "Taro" under bidirectical #== method.", but failed. (filename.rb:49:in `block (3 levels) in <main>')

----------------------------------------------------------------------------
1 categorizies, 4 scopes, 10 behaviors
    pass: 9
    fail: 1
=end

