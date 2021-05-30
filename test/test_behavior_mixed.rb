# coding: us-ascii
# frozen_string_literal: true

require_relative 'helper'

class Test_Decalre_Behavior_Mixed < Test::Unit::TestCase
  include DeclareHelpers

  CODE = <<"RUBY"
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
    can :birth
    is_a Person
    kind_of Object

    NOT 'Taro'

    The john.name do |name|
      kind String
      is 'John' # pass
      is 'john' #fail
      truthy name.kind_of?(String)
      falsy name.match(/[1-9]/)
    end

    The john.birth do
      kind_of Time
      kind_of String #fail
    end
  end
end
RUBY

  def test_mixed_result
    result = execute_ruby_code_in_other_process(CODE)
    assert_match(/3 scopes, 12 assertions, 2 failures\Z/, result.all_output)
    assert_equal(2, result.exitstatus)
  end
end
