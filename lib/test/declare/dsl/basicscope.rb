# Copyright (C) 2012 Kenichi Kamiya

require_relative 'callerentry'

module Test; module Declare; module DSL

  # @note
  #   Can't inherit from BasicObject, for namespace of toplevel constants
  class BasicScope
    
    alias_method :_caller, :caller
    
    def called_from(level=0)
      CallerEntry.parse caller[1 + level]
    end

    def The(target, &block)
      ::Test::Declare.scope! target, called_from
      ::Test::Declare::DSL::Scope.new(target).instance_exec(target, &block)
    rescue Exception
      raise UnhandledError, "#{$!.inspect}/#{$!.backtrace}"
    end

  end

end; end; end
