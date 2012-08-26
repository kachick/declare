# Copyright (C) 2012 Kenichi Kamiya

require_relative 'declare/version'
require_relative 'declare/exceptions'
require_relative 'declare/singleton_class'
require_relative 'declare/main'
require_relative 'declare/dsl/basicscope'
require_relative 'declare/dsl/assertions'
require_relative 'declare/dsl/scope'

# momkey-ext

class Test::Unit::TestCase

  def __name__
    @__name__ ||= "Test_fsrdgkrh_#{rand 777}"
  end

end
