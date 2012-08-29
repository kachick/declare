module Declare

  module Assertions

    # @param [Class] klass
    def A?(klass)
      @it.instance_of? klass
    end
    
    alias_method :a?, :A?

    # @param [Class] klass
    def A(klass)
      if A? klass
        pass
      else
        failure "It is #{klass}'s instance.", "It is #{@it.class}'s instance."
      end
    ensure
      _declared!
    end
    
    alias_method :a, :A
    alias_method :IS_A, :A
    alias_method :is_a, :IS_A

    def KIND?(family)
      @it.kind_of? family
    end
    
    alias_method :kind?, :KIND?
    
    def KIND(family)
      if KIND? family
        pass
      else
        failure 0, "It's family of #{family.inspect}"
      end
    ensure
      _declared!
    end
    
    alias_method :kind, :KIND
    alias_method :KIND_OF, :KIND
    alias_method :kind_of, :KIND_OF

    # true if can use for hash-key
    def HASHABLE?(sample)
      sample = sample.nil? ? @it : sample
      
      (bidirectical? :eql?, sample) && 
      (@it.hash == sample.hash) &&
      ({@it => true}.has_key? sample)
    end
    
    alias_method :hashable?, :HASHABLE?
    
    def HASHABLE(sample=nil)
      if HASHABLE? sample
        pass
      else
        failure 'It\'s able to use key in any Hash object.'
      end
    ensure
      _declared!
    end

    alias_method :hashable, :HASHABLE
    alias_method :EQL, :HASHABLE
    alias_method :eql, :EQL
    
    # true if under "=="
    def IS?(other)
      @it == other
    end

    alias_method :is?, :IS?
    
    def IS(other)
      if IS? other
        pass
      else
        failure 'it == other', "#{@it.inspect} == #{other.inspect}"
      end
    ensure
      _declared!
    end

    alias_method :is, :IS

    def NOT?(other)
      (bidirectical? :!=, other) && 
      (!(@it == other)) &&
      (!(other == @it))
    end
    
    alias_method :not?, :NOT?
    
    def NOT(other)
      if NOT? other
        pass
      else
        failure "It isn't #{other.inspect}."
      end
    ensure
      _declared!
    end
    
    # @param [#===] condition
    def MATCH?(condition)
      condition === @it
    end

    alias_method :match?, :MATCH?
    alias_method :SATISFY?, :MATCH?
    alias_method :satisfy?, :SATISFY?
  
    # @param [#===] condition
    def MATCH(condition)
      if ret = MATCH?(condition)
        pass
      else
        failure "return(#{condition} === It) is not nil/false.", "return(#{ret})."
      end
    ensure
      _declared!
    end
    
    alias_method :match, :MATCH
    alias_method :SATISFY, :MATCH
    alias_method :satisfy, :SATISFY

    # true if bidirectical passed #equal, and __id__ is same value
    def EQUAL?(other)
      (bidirectical? :equal?, other) && (@it.__id__ == other.__id__)
    end
    
    def EQUAL(other)
      if EQUAL? other
        pass
      else
        failure "It(ID: ) same object/identififer with #{other.inspect}(ID: #{other.__id__}).", "#{@it.inspect}(ID: #{@it.__id__})"
      end
    ensure
      _declared!
    end
    
    alias_method :equal, :EQUAL
    alias_method :SAME, :EQUAL
    alias_method :same, :SAME
    
    # true if under "respond_to?"
    def RESPOND?(message)
      @it.respond_to? message
    end

    alias_method :respond?, :RESPOND?

    def RESPOND(message)
      if RESPOND? message
        pass
      else
        failure "It can behave the order ##{message}."
      end
    ensure
      _declared!
    end
    
    alias_method :respond, :RESPOND
    alias_method :CAN, :RESPOND
    alias_method :can, :CAN
 
    def TRUTHY?(object)
      !! object
    end

    alias_method :truthy?, :TRUTHY?

    def TRUTHY(object)
      if TRUTHY? object
        pass
      else
        failure "\"#{object.inspect}\" is a truthy one."
      end
    ensure
      _declared!
    end
    
    alias_method :truthy, :TRUTHY
    alias_method :OK, :TRUTHY
    alias_method :ok, :OK
 
    def FALTHY?(object)
      ! object
    end

    alias_method :falthy?, :FALTHY?

    def FALTHY(object)
      if FALTHY? object
        pass
      else
        failure "\"#{object.inspect}\" is a falthy one."
      end
    ensure
      _declared!
    end
    
    alias_method :falthy, :FALTHY
    alias_method :NG, :FALTHY
    alias_method :ng, :NG
    
    # pass if occured the error is a own/subclassis instance
    # @param [Class] exception_klass
    def RESCUE(exception_klass, &block)
      block.call
    rescue exception_klass
      pass
    rescue ::Exception
      failure "It raises a exception kind of #{exception_klass}.", "Real is faced another exception the #{$!.class}.", 2
    else
      failure "It raises a exception kind of #{exception_klass}.", "Real is not faced any exceptions.", 2
    ensure
      _declared!
    end
    
    # pass if occured the error is just a own instance
    # @param [Class] exception_klass
    def CATCH(exception_klass, &block)
      block.call
    rescue ::Exception
      if $!.instance_of? exception_klass
        pass
      else
        failure "It raises the exception #{exception_klass}.", "Real is faced another exception the #{$!.class}.", 2
      end
    else
      failure "It raises the exception #{exception_klass}.", "Real is not faced any exceptions.", 2
    ensure
      _declared!
    end

    private

    def bidirectical?(comparison, other)
      (@it.__send__ comparison, other) && (other.__send__ comparison, @it)
    end
    
    def _declared!
      ::Declare.declared!
    end
    
    def pass
      ::Declare.pass!
    end
    
    def failure(ecpected, actual=false, level=1)
      ::Declare.failure! "#{_declare_called_from level}\n  Expected: #{ecpected}\n  Actual  : #{actual}\n\n"
    end
    
  end
  
end
