# coding: us-ascii
# frozen_string_literal: true

require_relative 'helper'

class Test_Declare_Behavior_Exception_Outer_Declare < Test::Unit::TestCase
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
    end
  end
end

raise Exception, 'Unexpected exception occurred out of scope'
RUBY

  def test_result
    result = execute_ruby_code_in_other_process(CODE)
    assert_match(/Unexpected exception occurred out of scope/, result.all_output)
    assert_equal(1, result.exitstatus)
  end
end
