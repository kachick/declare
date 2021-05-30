# coding: us-ascii
# frozen_string_literal: true

require_relative 'assertions'

module Declare
  class BasicScope
    # @return [AssertionsScope]
    def The(target, &block)
      Declare.scope!(target, _declare_called_from)
      Declare.new_scope(target, &block)
    end

    # @param [Integer] level
    # @return [CallerEntry]
    def _declare_called_from(level=0)
      CallerEntry.parse(caller[1 + level])
    end
  end

  class AssertionsScope < BasicScope
    include Assertions

    attr_reader :it

    def initialize(target)
      super()
      @it = target
    end
  end
end
