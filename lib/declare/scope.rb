# Copyright (C) 2012 Kenichi Kamiya


module Declare

  class Scope < BasicObject
    
    def initialize(object)
      @target = object
    end
    
    def it
      @target
    end
    
    def A?(klass)
      @target.instance_of? klass
    end
    
    alias_method :a?, :A?
    
    def A(klass)
      if A? klass
        pass
      else
        failure _caller, "It's instance of #{klass}", "Real is instance of #{@target.class}."
      end
    ensure
      _declared!
    end
    
    alias_method :a, :A

    def KIND?(family)
      @target.kind_of? family
    end
    
    alias_method :kind?, :KIND?
    
    def KIND(family)
      if KIND? family
        pass
      else
        failure _caller, "It's family of #{family.inspect}"
      end
    ensure
      _declared!
    end
    
    alias_method :kind, :KIND

    # true if can use for hash-key
    def HASHABLE?(sample)
      sample = sample.nil? ? @target : sample
      
      (bidirectical? :eql?, sample) && 
      (@target.hash == sample.hash) &&
      ({@target => true}.has_key? sample)
    end
    
    alias_method :hashable?, :HASHABLE?
    
    def HASHABLE(sample=nil)
      if HASHABLE? sample
        pass
      else
        failure _caller, 'It\'s able to use key in any Hash object.'
      end
    ensure
      _declared!
    end

    alias_method :hashable, :HASHABLE

    # true if under "=="
    def IS?(other)
      bidirectical? :==, other
    end

    alias_method :is?, :IS?
    
    def IS(other)
      if IS? other
        pass
      else
        failure _caller, "It\'s euqualy value with #{other.inspect} under bidirectical #== method."
      end
    ensure
      _declared!
    end

    alias_method :is, :IS

    def NOT?(other)
      (bidirectical? :!=, other) && 
      (!(@target == other)) &&
      (!(other == @target))
    end
    
    alias_method :not?, :NOT?
    
    def NOT(other)
      if NOT? other
        pass
      else
        failure _caller, "It isn't #{other.inspect}."
      end
    ensure
      _declared!
    end
    
    def MATCH?(condition)
      condition === @target
    end

    alias_method :match?, :MATCH?
    alias_method :SATISFY?, :MATCH?
    alias_method :satisfy?, :SATISFY?

    def MATCH(condition)
      if MATCH? condition
        pass
      else
        failure _caller, "It satisfies a condition of #{condition.inspect}."
      end
    ensure
      _declared!
    end
    
    alias_method :match, :MATCH
    alias_method :SATISFY, :MATCH
    alias_method :satisfy, :SATISFY

    # true if bidirectical passed #equal, and __id__ is same value
    def EQUAL?(other)
      (bidirectical? :equal?, other) && (@target.__id__ == other.__id__)
    end
    
    def EQUAL(other)
      if EQUAL? other
        pass
      else
        failure _caller, "It's same object/identififer with #{other.inspect}(#{other.__id__})."
      end
    ensure
      _declared!
    end
    
    alias_method :equal, :EQUAL

    # true if under "respond_to?"
    def RESPOND?(message)
      @target.respond_to? message
    end

    alias_method :respond?, :RESPOND?

    def RESPOND(message)
      if RESPOND? message
        pass
      else
        failure _caller, "It can behave the order ##{message}."
      end
    ensure
      _declared!
    end
    
    alias_method :respond, :RESPOND
    
    # pass if occured the error is a own/subclassis instance
    def RESCUE(exception_klass, &block)
      block.call
    rescue exception_klass
      pass
    rescue ::Exception
      failure _caller, "It raises a exception kind of #{exception_klass}.", "Real is faced another exception the #{$!.class}."
    else
      failure _caller, "It raises a exception kind of #{exception_klass}.", "Real is not faced any exceptions."
    ensure
      _declared!
    end
    
    # pass if occured the error is just a own instance
    def CATCH(exception_klass, &block)
      block.call
    rescue ::Exception
      if $!.instance_of? exception_klass
        pass
      else
        failure _caller, "It raises the exception #{exception_klass}.", "Real is faced another exception the #{$!.class}."
      end
    else
      failure _caller, "It raises the exception #{exception_klass}.", "Real is not faced any exceptions."
    ensure
      _declared!
    end

    private
    
    def _caller
      ::Kernel.caller
    end

    def bidirectical?(comparison, other)
      (@target.__send__ comparison, other) && (other.__send__ comparison, @target)
    end
    
    def _declared!
      ::Declare.declared!
    end
    
    def pass
      ::Declare.pass!
    end
    
    def failure(__caller, declared, real=nil)
      ::Declare.failure! "#{@target.inspect} is declared \"#{declared}\", but failed. #{real}(#{__caller.first})"
    end

  end

end