# coding: us-ascii
# frozen_string_literal: true

require_relative 'helper'

require_relative '../lib/declare'

class Test_Declare_Constants < Test::Unit::TestCase
  def test_version
    assert do
      Declare::VERSION.instance_of?(String)
    end

    assert do
      Declare::VERSION.frozen?
    end

    assert do
      Gem::Version.correct?(Declare::VERSION)
    end
  end
end
