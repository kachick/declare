$VERBOSE = true

class Person
  
  attr_reader :name, :birth
  
  def initialize(name)
    @name = name
    @birth = Time.now
  end

end

require_relative '../lib/declare/autorun'

The Person.new('John') do |john|

  can :name
  can :birth
  is_a Person
  kind_of Object
  
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
