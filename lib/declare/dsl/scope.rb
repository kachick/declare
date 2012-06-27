# Copyright (C) 2012 Kenichi Kamiya

require_relative 'basicscope'
require_relative 'assertions'

module Declare; module DSL

  class Scope < BasicScope
    
    include Assertions
    
    attr_reader :it
    
    def initialize(object)
      @it = object
    end

  end
  
end; end
