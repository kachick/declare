# coding: us-ascii
# frozen_string_literal: true

require_relative 'helper'

class Test_Decalre_Behavior_Exception_Inner_NestedDeclare < Test::Unit::TestCase
  CODE = <<"RUBY"
class Person
  attr_reader :name, :birth

  def initialize(name)
    @name = name
    @birth = Time.now
  end

end

app_dir = "#{File.expand_path('..', File.dirname(__FILE__))}"
require app_dir + '/lib/declare/autorun'

The Person.new('John') do |john|
  can :name

  The john.birth do
    kind_of Time
    raise Exception
  end
end
RUBY

  def test_result
    out = `ruby -w 2>&1 <<RUBY_CODE
#{CODE}
RUBY_CODE
`
    assert_equal(1, $?.exitstatus)
    assert_match(/Exception/, out)
  end
end
