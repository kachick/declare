$VERBOSE = true

require_relative '../lib/declare'

Declare do

  The(Array) {
    
    a       Module
    kind    Hash
    respond :to_str
    
  }

  The(1) {
    
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

# Array
Array is declared "It's instance of Module", but failed. Real is instance of Class.(failuers.rb:9:in `block (2 levels) in <main>')
Array is declared "It's family of Hash", but failed. (failuers.rb:10:in `block (2 levels) in <main>')
Array is declared "It can behave the order #to_str.", but failed. (failuers.rb:11:in `block (2 levels) in <main>')

# 1
1 is declared "It's euqualy value with 1.1 under bidirectical #== method.", but failed. (failuers.rb:17:in `block (2 levels) in <main>')
1 is declared "It's euqualy value with 2 under bidirectical #== method.", but failed. (failuers.rb:18:in `block (2 levels) in <main>')
1 is declared "It isn't 1.", but failed. (failuers.rb:19:in `block (2 levels) in <main>')
1 is declared "It satisfies a condition under 2..3.", but failed. (failuers.rb:20:in `block (2 levels) in <main>')
1 is declared "It's same object/identififer with 1.0(ID: 22148112).", but failed. Real is 1(ID: 3)(failuers.rb:21:in `block (2 levels) in <main>')
1 is declared "It's family of Float", but failed. (failuers.rb:22:in `block (2 levels) in <main>')
1 is declared "It's instance of Integer", but failed. Real is instance of Fixnum.(failuers.rb:23:in `block (2 levels) in <main>')
1 is declared "It can behave the order #to_str.", but failed. (failuers.rb:24:in `block (2 levels) in <main>')
1 is declared "It raises a exception kind of SyntaxError.", but failed. Real is faced another exception the NameError.(failuers.rb:26:in `block (2 levels) in <main>')
1 is declared "It raises the exception RuntimeError.", but failed. Real is faced another exception the NoMethodError.(failuers.rb:30:in `block (2 levels) in <main>')

----------------------------------------------------------------------------
1 categorized, 2 scoped, 13 declared
    pass: 0
    fail: 13

=end
