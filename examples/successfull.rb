$VERBOSE = true

require_relative '../lib/declare'

Declare do

  on(Array) {
    
    a       Class
    kind    Module
    respond :new
    
  }

  on(1) {
    
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

end

=begin

1 categorizies, 2 scopes, 14 behaviors
    pass: 14
    fail: 0

=end

