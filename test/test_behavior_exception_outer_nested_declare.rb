# coding: us-ascii
# frozen_string_literal: true

require_relative 'helper'

class Test_Declare_Behavior_Exception_Outer_NestedDeclare < Test::Unit::TestCase
  include DeclareHelpers

  CODE = <<"RUBY".freeze
class Person
  attr_reader :name, :birth

  def initialize(name)
    @name = name
    @birth = Time.now
  end
end

app_dir = "#{File.expand_path('..', __dir__)}"
require app_dir + '/lib/declare/autorun'

Declare.describe do
  The Person.new('John') do |john|
    can :name

    The john.birth do
      kind_of Time

      raise Exception, 'Unexpected exception occurred in nested scope'
    end
  end
end
RUBY

  def test_result
    result = execute_ruby_code_in_other_process(CODE)
    assert_match(/Unexpected exception occurred in nested scope/, result.all_output)
    assert_equal(1, result.exitstatus)
  end
end
