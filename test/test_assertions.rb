# coding: us-ascii

require 'test/unit'

$VERBOSE = true

require_relative '../lib/declare'

class Foo
  include Declare::Assertions
  
  attr_accessor :it
end

class Test_Declare_Assertions < Test::Unit::TestCase
  
  Scope = Foo.new
  
  def test_A?
    Scope.it = []
    assert_same true, Scope.A?(Array)
    assert_same false, Scope.A?(Object)
  end
  
  def test_KIND?
    Scope.it = []
    assert_same true, Scope.KIND?(Array)
    assert_same true, Scope.KIND?(Enumerable)
    assert_same true, Scope.KIND?(Object)
    assert_same false, Scope.KIND?(Hash)
  end
  
  def test_EQL?
    Scope.it = 1.0
    assert_same false, Scope.EQL?(1)
    assert_same true, Scope.EQL?(1.0)
    assert_same false, Scope.EQL?(1.1)
  end
  
  def test_IS?
    Scope.it = 1.0
    assert_same true, Scope.IS?(1)
    assert_same true, Scope.IS?(1.0)
    assert_same false, Scope.IS?(1.1)
  end

  def test_is_predicate?
    Scope.it = []
    assert_same true, Scope.is_predicate?(:empty)
    assert_same false, Scope.is_predicate?(:nil)
  end

  def test_NOT?
    Scope.it = 1.0
    assert_same false, Scope.NOT?(1)
    assert_same false, Scope.NOT?(1.0)
    assert_same true, Scope.NOT?(1.1)
  end
  
  def test_MATCH?
    Scope.it = 'a'
    assert_same true, Scope.MATCH?(/a/)
    assert_same true, Scope.MATCH?('a')
    assert_same false, Scope.MATCH?(/b/)
  end
  
  def test_EQUAL?
    str = 'str'
    Scope.it = str
    assert_same false, Scope.EQUAL?('str')
    assert_same true, Scope.EQUAL?(str)
  end

  def test_RESPOND?
    Scope.it = ''
    assert_same true, Scope.RESPOND?(:gsub)
    assert_same true, Scope.RESPOND?(:__id__)
    assert_same false, Scope.RESPOND?(:FOOOOO)
  end

  def test_TRUTHY?
    Scope.it = nil
    assert_same true, Scope.TRUTHY?(true)
    assert_same true, Scope.TRUTHY?(0)
    assert_same true, Scope.TRUTHY?('')
    assert_same false, Scope.TRUTHY?(false)
    assert_same false, Scope.TRUTHY?(nil)
  end
  
  def test_FALTHY?
    Scope.it = nil
    assert_same false, Scope.FALTHY?(true)
    assert_same false, Scope.FALTHY?(0)
    assert_same false, Scope.FALTHY?('')
    assert_same true, Scope.FALTHY?(false)
    assert_same true, Scope.FALTHY?(nil)
  end
  
end
