# coding: us-ascii
# frozen_string_literal: true
$VERBOSE = true

require_relative '../lib/declare/autorun'

Declare.describe do
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
    eql     1
    kind    Numeric
    a       Integer
    respond :upto

    RESCUE Exception do
      raise
    end

    CATCH NameError do
      to_str
    end
  }
end
