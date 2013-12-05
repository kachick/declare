# coding: us-ascii

module Declare

  module Assertions

    # @param [Class] klass
    def INSTANCE_OF?(klass)
      @it.instance_of?(klass)
    end
    
    alias_method :A?, :INSTANCE_OF?
    alias_method :a?, :A?


    # @param [Class] klass
    def INSTANCE_OF(klass)
      if INSTANCE_OF? klass
        pass
      else
        failure("It is #{klass}'s instance.",
                "It is #{@it.class}'s instance.")
      end
    ensure
      _declared!
    end
    
    alias_method :A, :INSTANCE_OF
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
        failure("It is kind of #{family.inspect}.",
                (family.kind_of?(Module) ? "It.class(#{@it.class}) <-> other.ancestors(#{family.ancestors})" : "It is not kind of #{family.inspect}"))
      end
    ensure
      _declared!
    end
    
    alias_method :kind, :KIND
    alias_method :KIND_OF, :KIND
    alias_method :kind_of, :KIND_OF

    # true if can use for hash-key
    def EQL?(sample) 
      @it.eql?(sample) && sample.eql?(@it) && (@it.hash == sample.hash) &&
      ({@it => true}.has_key? sample)
    end
    
    def EQL(sample)
      if EQL? sample
        pass
      else
        failure 'It\'s able to use key in any Hash object.'
      end
    ensure
      _declared!
    end

    alias_method :eql, :EQL
    
    # true if under "=="
    def IS?(other, bidirectical=true)
      (@it == other) && (bidirectical ? (other == @it) : true)
    end

    alias_method :is?, :IS?
    
    def IS(other)
      if IS? other
        pass
      else
        failure('it == other',
                "#{@it.inspect} == #{other.inspect}")
      end
    ensure
      _declared!
    end

    alias_method :is, :IS

    def NOT?(other)
      (@it != other) && (other != @it) && !(IS?(other))
    end
    
    alias_method :not?, :NOT?
    
    def NOT(other)
      if NOT? other
        pass
      else
        failure("It is not other(#{other.inspect}).",
                "It is other(#{other.inspect}).")
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
        failure("return(#{condition} === It) is not nil/false.",
                "return(#{ret}).")
      end
    ensure
      _declared!
    end
    
    alias_method :match, :MATCH
    alias_method :SATISFY, :MATCH
    alias_method :satisfy, :SATISFY

    # true if bidirectical passed #equal, and __id__ is same value
    def EQUAL?(other)
      @it.equal?(other) && other.equal?(@it) && (@it.__id__.equal? other.__id__)
    end
    
    def EQUAL(other)
      if EQUAL? other
        pass
      else
        failure("@it.equal?(other) && other.equal?(@it) && (@it.__id__.equal? other.__id__) #=> truthy",
                "falthy, it(#{@it.__id__}), other(#{other.__id__})")
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
      message = message.to_sym

      if ret = RESPOND?(message)
        pass
      else
        failure("It.respond_to?(#{message.inspect}) #=> truthy(not nil/false)",
                "It.respond_to?(#{message.inspect}) #=> #{ret.inspect}")
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
        failure("It is a truthy(not nil/false) object.",
                "\"#{object.inspect}\" is a falthy(nil/false) object.")
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
        failure("It is a falthy(nil/false) object.",
                "\"#{object.inspect}\" is a truthy(not nil/false) object.")
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
      fmt_err = ->err_cls{err_cls.ancestors.take_while{|mod|mod != Object}.join(' < ')}
      block.call
    rescue exception_klass
      pass
    rescue ::Exception
      failure("Faced a exception, that kind of #{exception_klass}(#{fmt_err.call exception_klass}).",
              "Faced a exception, that instance of #{$!.class}(#{fmt_err.call $!.class}).", 2)
    else
      failure("Faced a exception, that kind of #{exception_klass}(#{fmt_err.call exception_klass}).",
              'The block was not faced any exceptions.', 2)
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
        failure("Faced a exception, that instance of #{exception_klass}.",
                "Faced a exception, that instance of #{$!.class}.", 2)
      end
    else
      failure("Faced a exception, that instance of #{exception_klass}.",
              'The block was not faced any exceptions.', 2)
    ensure
      _declared!
    end

    private
    
    def _declared!
      ::Declare.declared!
    end
    
    def pass
      ::Declare.pass!
    end
    
    def failure(ecpected, actual, level=1)
      ::Declare.failure! "#{_declare_called_from level}\n  Expected: #{ecpected}\n  Actual  : #{actual}\n\n"
    end
    
  end
  
end