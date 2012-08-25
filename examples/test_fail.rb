$VERBOSE = true

require_relative '../lib/test/declare'

Declare do

  The(Array) {
    
    a       Module
    kind    Hash
    respond :to_str
    
    The(it.new) {

      a Hash
      
    }

    
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

Below definitions are not satisfied some conditions.
====================================================
## Array ## [filename.rb:7]
  * "It's instance of Module", but MISMATCHED. Real is instance of Class.[filename.rb:9]
  * "It's family of Hash", but MISMATCHED. [filename.rb:10]
  * "It can behave the order #to_str.", but MISMATCHED. [filename.rb:11]

### [] ### [filename.rb:13]
  * "It's instance of Hash", but MISMATCHED. Real is instance of Array.[filename.rb:15]

## 1 ## [filename.rb:22]
  * "It's euqualy value with 1.1 under bidirectical #== method.", but MISMATCHED. [filename.rb:24]
  * "It's euqualy value with 2 under bidirectical #== method.", but MISMATCHED. [filename.rb:25]
  * "It isn't 1.", but MISMATCHED. [filename.rb:26]
  * "It satisfies a condition under 2..3.", but MISMATCHED. [filename.rb:27]
  * "It's same object/identififer with 1.0(ID: 21752556).", but MISMATCHED. Real is 1(ID: 3)[filename.rb:28]
  * "It's family of Float", but MISMATCHED. [filename.rb:29]
  * "It's instance of Integer", but MISMATCHED. Real is instance of Fixnum.[filename.rb:30]
  * "It can behave the order #to_str.", but MISMATCHED. [filename.rb:31]
  * "It raises a exception kind of SyntaxError.", but MISMATCHED. Real is faced another exception the RuntimeError.[filename.rb:33]
  * "It raises the exception RuntimeError.", but MISMATCHED. Real is faced another exception the Exception.[filename.rb:37]

----------------------------------------------------------------------------
1 categorizies, 3 scopes, 14 behaviors
    pass: 0
    fail: 14

=end
