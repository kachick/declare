# coding: us-ascii
# frozen_string_literal: true

require_relative 'helper'
require_relative '../lib/declare'

class Test_Declare_Basic_Interface < Test::Unit::TestCase
  class Person
    attr_reader :name, :birth

    def initialize(name)
      @name = name
      @birth = Time.now
    end
  end

  def test_failures
    Declare.describe do
      The [42] do |ary|
        can :size

        NOT 'Taro'

        The ary.first do
          is 42
        end

        The ary.size do
          is 42 # fail
        end
      end
    end

    Declare.describe do
      The Person.new('John') do |john|
        can :name
        can :birth
        is_a Person
        kind_of Object

        NOT 'Taro'

        The john.name do |name|
          kind String
          is 'Taro' # fail
          is 'John'
          is 'john' # fail
          truthy name.kind_of?(String)
          falsy name.match(/[1-9]/)
        end

        The john.birth do
          kind_of Time
          kind_of String # fail
        end
      end
    end

    assert_equal(4, Declare.failure_count)
    assert_equal(3, Declare.failures.size)
    Declare.failures.each_pair do |summary, reports|
      assert do
        summary.instance_of?(Declare::ScopeSummary)
      end

      assert do
        reports.instance_of?(Array)
      end

      assert do
        !reports.empty?
      end

      assert do
        reports.all?(String)
      end
    end
  end
end
