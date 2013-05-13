# coding: us-ascii
require 'test/unit'

class Test_Decalre_Behavior_Exception_Outer_Declare < Test::Unit::TestCase
  CODE = <<"EOD"
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
  end
end

raise Exception
EOD

  def test_result
    out = `ruby -w 2>&1 <<EOD
#{CODE}
EOD
`
    assert_equal(1, $?.exitstatus)
    assert_match(/Exception/, out)
  end
end