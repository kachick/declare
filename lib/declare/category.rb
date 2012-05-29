# Copyright (C) 2012 Kenichi Kamiya


module Declare

  class Category < BasicObject
    
    def The(object, &block)
      Scope.new(object).instance_exec(&block)
    rescue ::Exception
      ::Declare.unexpected_failure_in_the object, $!, ::Kernel.caller
    ensure
      ::Declare.scope!
    end
    
  end

end