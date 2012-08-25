$VERBOSE = true


class Person
  
  attr_reader :name, :birth
  
  def initialize(name)
    @name = name
    @birth = Time.now
  end

end

require_relative '../lib/test/declare'

Declare do
  
  The Person.new('John') do |john|

    respond :name
    respond :birth
    a Person
    kind Object
    
    NOT 'Taro'
    
    The john.name do |name|
      kind String
      is 'Taro'
      truthy name.kind_of?(String)
      falthy name.match(/[1-9]/)
    end

    The john.birth do
      kind Time
    end

  end
  
end

=begin
Below definitions are not satisfied some conditions.
====================================================
### "John" ### [mixed.rb:28]
  * "It's euqualy value with "Taro" under bidirectical #== method.", but MISMATCHED. [mixed.rb:30]

----------------------------------------------------------------------------
1 categorizies, 3 scopes, 10 behaviors
    pass: 9
    fail: 1
=end

