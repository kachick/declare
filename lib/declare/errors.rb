# coding: us-ascii
# frozen_string_literal: true

module Declare
  class UnhandledError < Exception; end
  class FrameworkError < StandardError; end
  class DupulicatedCategoryError < FrameworkError; end
end
