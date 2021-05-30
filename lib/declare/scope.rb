# coding: us-ascii
# frozen_string_literal: true

require_relative 'assertions'

module Declare
  class Scope
    include Assertions

    attr_reader :it

    def initialize(target)
      @it = target
    end
  end
end
