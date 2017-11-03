# coding: us-ascii

module Declare
  module ObjectExtension
    private

    # @return [Scope]
    def The(target, &block)
      Declare.scope! target, _declare_called_from
      Declare.new_scope(target, &block)
    end

    alias_method :_original_caller, :caller

    # @param [Integer] level
    # @return [CallerEntry]
    def _declare_called_from(level=0)
      CallerEntry.parse _original_caller[1 + level]
    end
  end
end