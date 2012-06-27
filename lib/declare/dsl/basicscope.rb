# Copyright (C) 2012 Kenichi Kamiya

require_relative 'callerentry'

module Declare; module DSL

  # @note
  #   Can't inherit from BasicObject, for namespace of toplevel constants
  class BasicScope
    
    kernel_methods = (
      Kernel.instance_methods(false)         | 
      Kernel.private_instance_methods(false)
    )

    requires = [:raise, :caller, :object_id, :p, :puts, :print]
    
    # @note
    #   like a BasicObject
    (kernel_methods - requires).each do |method_name|
      undef_method method_name
    end
    
    alias_method :_caller, :caller
    
    def called_from(level=0)
      CallerEntry.parse caller[1 + level]
    end

    def The(target, &block)
      Declare.scope! target, called_from
      Declare::DSL::Scope.new(target).instance_exec(target, &block)
    rescue Exception
      raise UnhandledError, "#{$!.inspect}/#{$!.backtrace}"
    end

  end

end; end