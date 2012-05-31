# Copyright (C) 2012 Kenichi Kamiya

module Declare

  module DSL

    # @note
    #   Can't inherit from BasicObject, for NameSpace of Constants
    class Basic
      
      kernel_methods = (
        Kernel.instance_methods(false)         | 
        Kernel.private_instance_methods(false)
      )

      requires = [:raise, :caller, :object_id]
      
      # @note
      #   like a BasicObject
      (kernel_methods - requires).each do |method_name|
        undef_method method_name
      end
      
      alias_method :_caller, :caller

      def Focus(target, _caller=nil, &block)
        _caller ||= caller[0]
        Declare.scope! target, _caller
        Declare::DSL::Assertion.new(target).instance_exec(&block)
      rescue Exception
        #~ ::Declare.unexpected_failure_in_the target, $!, ::Kernel.caller
        raise UnhandledError, "#{$!.inspect}/#{$!.backtrace}"
      end

      alias_method :The, :Focus
      alias_method :on, :Focus

    end

  end

end