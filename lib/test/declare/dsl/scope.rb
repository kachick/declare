# Copyright (C) 2012 Kenichi Kamiya

require_relative 'basicscope'
require_relative 'assertions'

module Test; module Declare; module DSL

  module Scope

    include BasicScope
    extend BasicScope
    extend Assertions
    
    attr_reader :it
    
    def initialize(object)
      @it = object
    end

  end
  
end; end; end
