# declare

![Build Status](https://github.com/kachick/declare/actions/workflows/test_behaviors.yml/badge.svg?branch=main)
[![Gem Version](https://badge.fury.io/rb/declare.png)](http://badge.fury.io/rb/declare)

A unit testing framework

## Usage

Require Ruby 2.6 or later

Add below code into your Gemfile`

```ruby
group :test do
  gem 'declare', '>= 0.3.1', '< 0.4.0'
end
```

### Overview

Target Code

```ruby
class Person
  attr_reader :name, :birth

  def initialize(name)
    @name = name
    @birth = Time.now
  end
end
```

Test Code

```ruby
require 'declare/autorun'

Declare.describe do
  The Person.new('John') do |john|
    can :name
    can :birth
    is_a Person
    kind_of Object

    NOT 'Taro'

    The john.name do |name|
      kind_of String
      is_a Person
      ok name.kind_of?(String)
      ng name.match(/[1-9]/)
    end

    The john.birth do
      kind_of Time
    end
  end
end
```

Report

```markdown
Detail testing report
=====================

### "John" ### [./example/mixed.rb:25]

* ./example/mixed.rb:27
  Expected: it == other
  Actual  : "John" == "Taro"

------------------------------------------------------------------------------
3 scopes, 10 assertions, 1 failures
```

```console
$ echo $?
1(count of the failures)
```

### How to use in Rake Tasks likely with test-unit

Replace as below.

```ruby
require 'test/unit'
```

to

```ruby
require 'declare/autorun'
```

## Links

* [Repository](https://github.com/kachick/declare)
* [API documents](https://kachick.github.io/declare)
