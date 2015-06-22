# coding: us-ascii
$VERBOSE = true

class Person
  
  attr_reader :name, :birth
  
  def initialize(name)
    @name = name
    @birth = Time.now
  end

  def named?
    ! @name.empty?
  end

end

require_relative '../lib/declare/autorun'

The Person.new('John') do |john|

  can :name
  can :birth
  is_a Person
  kind_of Object
  is_named
  
  NOT 'Taro'
  
  The john.name do |name|
    kind String
    is 'Taro'
    truthy name.kind_of?(String)
    falthy name.match(/[1-9]/)
  end

  The john.birth do
    kind_of Time
  end

end
