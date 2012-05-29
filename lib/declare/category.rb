# Copyright (C) 2012 Kenichi Kamiya


module Declare

  class Category < BasicObject
    
    def The(target, &block)
      ::Declare.scope! target
      Scope.new(target).instance_exec(&block)
    rescue ::Exception
      ::Declare.unexpected_failure_in_the target, $!, ::Kernel.caller
    end
    
  end

end