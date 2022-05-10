# coding: us-ascii
# frozen_string_literal: true

require 'warning'

# How to use => https://test-unit.github.io/test-unit/en/
require 'test/unit'

require 'irb'
require 'power_assert/colorize'
require 'irb/power_assert'

Warning[:deprecated] = true
Warning[:experimental] = true

Warning.process do |_warning|
  :raise
end

class Test::Unit::TestCase
  module DeclareHelpers
    ExecuteResult = Struct.new(:all_output, :exitstatus, keyword_init: true)

    # @return [ExecuteResult]
    def execute_ruby_code_in_other_process(code)
      out = `ruby -w 2>&1 <<RUBY_CODE
#{code}
RUBY_CODE`

      ExecuteResult.new(all_output: out, exitstatus: $?.exitstatus)
    end
  end
end
