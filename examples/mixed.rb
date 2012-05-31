$VERBOSE = true


class Person
  
  attr_reader :name, :birth
  
  def initialize(name)
    @name = name
    @birth = Time.now
  end

end

require '../lib/declare'

Declare 'Simple case' do   # start to declare with categorizing text
  
  # This block is going to be evaluated in Declare::DSL::Basic
  # "it" was undefined
  
  The Person do
    
    # This block is going to be evaluated in Declare::DSL::Asertion(inherited Declare::DSL::Basic)
    # "it" is point to the "Person class"

    The it.new('John') do
    
      # This block is going to be evaluated in Declare::DSL::Asertion(inherited Declare::DSL::Basic)
      # "it" is point to the "John"

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

