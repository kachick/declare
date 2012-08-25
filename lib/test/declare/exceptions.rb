# Copyright (C) 2012 Kenichi Kamiya


module Test; module Declare

  class UnhandledError < Exception; end
  class FrameworkError < StandardError; end
  class DupulicatedCategoryError < FrameworkError; end

end; end
