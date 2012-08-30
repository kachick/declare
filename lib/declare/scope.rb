require_relative 'assertions'

module Declare

  class Scope
    
    include Assertions
    
    attr_reader :it
    
    def initialize(target)
      @it = target
    end
    
    alias_method :_caller, :caller

  end

end
