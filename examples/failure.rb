$VERBOSE = true

require_relative '../lib/declare'

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

Declare.report