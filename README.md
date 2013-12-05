declare
=======

Description
------------

A unit testing framework with tiny DSL.

Features
--------

* Simple syntax.
* Markdown looks Reports.
* Tiny keyboard typings :)

Usage
-----

### Overview

Product Code

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

The Person.new('John') do |john|
  can :name
  can :birth
  is_a Person
  kind_of Object
  
  NOT 'Taro'
  
  The john.name do |name|
    kind_of String
    is_a 'Taro'
    ok name.kind_of?(String)
    ng name.match(/[1-9]/)
  end

  The john.birth do
    kind_of Time
  end
end
```

Report

```markdown
Detail testing report
=====================

### "John" ### [./example/mixed.rb:26]

* ./example/mixed.rb:28
  Expected: it == other
  Actual  : "John" == "Taro"

------------------------------------------------------------------------------
3 scopes, 10 assertions, 1 failures
```

```bash
$ echo $? #=> 1(count of failed behaviors)
```

### How to use in Rake Tasks likely with test/unit

That's easy.
Replace below.

```ruby
require 'test/unit'
```

to

```ruby
require 'declare/autorun'
```

Requirements
-------------

* Ruby - [1.9.3 or later](http://travis-ci.org/#!/kachick/declare)

Install
-------

```bash
$ gem install declare
```

Build Status
-------------

[![Build Status](https://secure.travis-ci.org/kachick/declare.png)](http://travis-ci.org/kachick/declare)

Link
----

* [code](https://github.com/kachick/declare)
* [API](http://kachick.github.com/declare/yard/frames.html)
* [issues](https://github.com/kachick/declare/issues)
* [CI](http://travis-ci.org/#!/kachick/declare)
* [gem](https://rubygems.org/gems/declare)

License
-------

The MIT X11 License  
Copyright (c) 2012 Kenichi Kamiya  
See MIT-LICENSE for further details.
