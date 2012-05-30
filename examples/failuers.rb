$VERBOSE = true

require_relative '../lib/declare'

Declare do

  on(Array) {
    
    a       Module
    kind    Hash
    respond :to_str
    
    on(it.new) {

      a Hash
      
    }

    
  }

  on(1) {
    
    is      1.1
    is      2
    NOT     1
    match   2..3
    equal   1.0
    kind    Float
    a       Integer
    respond :to_str
    
    RESCUE SyntaxError do
      raise
    end
    
    CATCH RuntimeError do
      raise Exception
    end
    
  }

end


=begin

# Below points are not satisfied some conditions.

## "Array (failuers.rb:7)"
  * "It's instance of Module", but failed. Real is instance of Class.(failuers.rb:9:in `block (2 levels) in <main>')
  * "It's family of Hash", but failed. (failuers.rb:10:in `block (2 levels) in <main>')
  * "It can behave the order #to_str.", but failed. (failuers.rb:11:in `block (2 levels) in <main>')

## "[] (failuers.rb:13)"
  * "It's instance of Hash", but failed. Real is instance of Array.(failuers.rb:15:in `block (3 levels) in <main>')

## "1 (failuers.rb:22)"
  * "It's euqualy value with 1.1 under bidirectical #== method.", but failed. (failuers.rb:24:in `block (2 levels) in <main>')
  * "It's euqualy value with 2 under bidirectical #== method.", but failed. (failuers.rb:25:in `block (2 levels) in <main>')
  * "It isn't 1.", but failed. (failuers.rb:26:in `block (2 levels) in <main>')
  * "It satisfies a condition under 2..3.", but failed. (failuers.rb:27:in `block (2 levels) in <main>')
  * "It's same object/identififer with 1.0(ID: 21459768).", but failed. Real is 1(ID: 3)(failuers.rb:28:in `block (2 levels) in <main>')
  * "It's family of Float", but failed. (failuers.rb:29:in `block (2 levels) in <main>')
  * "It's instance of Integer", but failed. Real is instance of Fixnum.(failuers.rb:30:in `block (2 levels) in <main>')
  * "It can behave the order #to_str.", but failed. (failuers.rb:31:in `block (2 levels) in <main>')
  * "It raises a exception kind of SyntaxError.", but failed. Real is faced another exception the NameError.(failuers.rb:33:in `block (2 levels) in <main>')
  * "It raises the exception RuntimeError.", but failed. Real is faced another exception the NoMethodError.(failuers.rb:37:in `block (2 levels) in <main>')

----------------------------------------------------------------------------
1 categorizies, 3 scopes, 14 behaviors
    pass: 0
    fail: 14

=end
