# Copyright (C) 2012 Kenichi Kamiya


module Declare

  class Category < BasicObject
    
    def The(target, _caller=nil, &block)
      _caller ||= ::Kernel.caller[0]
      ::Declare.scope! target, _caller
      Scope.new(target).instance_exec(&block)
    rescue ::Exception
      #~ ::Declare.unexpected_failure_in_the target, $!, ::Kernel.caller
      ::Kernel.raise UnhandledError, "#{$!.inspect}/#{$!.backtrace}"
    end
    
    alias_method :on, :The
    
  end

end