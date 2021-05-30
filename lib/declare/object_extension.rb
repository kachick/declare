# coding: us-ascii
# frozen_string_literal: true

module Declare
  module ObjectExtension
    private

    # @return [Scope]
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
end
