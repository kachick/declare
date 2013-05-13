# coding: us-ascii

module Declare

  class UnhandledError < Exception; end
  class FrameworkError < StandardError; end
  class DupulicatedCategoryError < FrameworkError; end

end