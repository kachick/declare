# coding: us-ascii
# frozen_string_literal: true

require_relative 'helper'

require_relative '../lib/declare'

class Test_Declare_Assertions < Test::Unit::TestCase
  class Foo
    include Declare::Assertions

    attr_accessor :it
  end

  Scope = Foo.new

  def test_A?
    Scope.it = []
    assert_equal true, Scope.A?(Array)
    assert_equal false, Scope.A?(Object)
  end

  def test_KIND?
    Scope.it = []
    assert_equal true, Scope.KIND?(Array)
    assert_equal true, Scope.KIND?(Enumerable)
    assert_equal true, Scope.KIND?(Object)
    assert_equal false, Scope.KIND?(Hash)
  end

  def test_EQL?
    Scope.it = 1.0
    assert_equal false, Scope.EQL?(1)
    assert_equal true, Scope.EQL?(1.0)
    assert_equal false, Scope.EQL?(1.1)
  end

  def test_IS?
    Scope.it = 1.0
    assert_equal true, Scope.IS?(1)
    assert_equal true, Scope.IS?(1.0)
    assert_equal false, Scope.IS?(1.1)
  end

  def test_NOT?
    Scope.it = 1.0
    assert_equal false, Scope.NOT?(1)
    assert_equal false, Scope.NOT?(1.0)
    assert_equal true, Scope.NOT?(1.1)
  end

  def test_MATCH?
    Scope.it = 'a'
    assert_equal true, Scope.MATCH?(/a/)
    assert_equal true, Scope.MATCH?('a')
    assert_equal false, Scope.MATCH?(/b/)
  end

  def test_EQUAL?
    str = 'str'
    Scope.it = str
    assert_equal true, Scope.EQUAL?(str)
  end

  def test_RESPOND?
    Scope.it = ''
    assert_equal true, Scope.RESPOND?(:gsub)
    assert_equal true, Scope.RESPOND?(:__id__)
    assert_equal false, Scope.RESPOND?(:FOOOOO)
  end

  def test_TRUTHY?
    Scope.it = nil
    assert_equal true, Scope.TRUTHY?(true)
    assert_equal true, Scope.TRUTHY?(0)
    assert_equal true, Scope.TRUTHY?('')
    assert_equal false, Scope.TRUTHY?(false)
    assert_equal false, Scope.TRUTHY?(nil)
  end

  def test_FALTHY?
    Scope.it = nil
    assert_equal false, Scope.FALSY?(true)
    assert_equal false, Scope.FALSY?(0)
    assert_equal false, Scope.FALSY?('')
    assert_equal true, Scope.FALSY?(false)
    assert_equal true, Scope.FALSY?(nil)
  end
end
