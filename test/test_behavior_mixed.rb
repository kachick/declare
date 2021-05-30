# coding: us-ascii
# frozen_string_literal: true

require_relative 'helper'

class Test_Decalre_Behavior_Mixed < Test::Unit::TestCase
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
  can :birth
  is_a Person
  kind_of Object

  NOT 'Taro'

  The john.name do |name|
    kind String
    is 'Taro' # pass
    is 'john' #fail
    truthy name.kind_of?(String)
    falsy name.match(/[1-9]/)
  end

  The john.birth do
    kind_of Time
  end
end
RUBY

  def test_result
    out = `ruby -w 2>&1 <<RUBY_CODE
#{CODE}
RUBY_CODE`
    assert_equal(2, $?.exitstatus)
    assert_match(/3 scopes, 11 assertions, 2 failures/, out)
  end
end
