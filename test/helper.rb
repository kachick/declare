# coding: us-ascii
# frozen_string_literal: true

require 'warning'

# How to use => https://test-unit.github.io/test-unit/en/
require 'test/unit'

require 'irb'
require 'power_assert/colorize'
require 'irb/power_assert'

if Warning.respond_to?(:[]=) # @TODO Removable this guard after dropped ruby 2.6
  Warning[:deprecated] = true
  Warning[:experimental] = true
end

Warning.process do |_warning|
  :raise
end

# class Test::Unit::TestCase
#   module MyNewLibraryHelpers
#     def awesome_helper
#       nil
#     end
#   end

#   module MyNewLibraryAssertions
#     def assert_awesome(object)
#       assert do
#         'foo'.instance_of?(String)
#       end
#     end
#   end
# end
