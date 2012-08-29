$VERBOSE = true

require_relative '../lib/declare'

The(Array) {
  
  a       Class
  kind    Module
  respond :new
  
}

The(1) {
  
  is      1.0
  is      1.to_r
  NOT     2
  match   1..3
  equal   1
  hashable
  kind    Integer
  a       Fixnum
  respond :upto
  
  RESCUE Exception do
    raise
  end
  
  CATCH NameError do
    to_str
  end
  
}

Declare.report