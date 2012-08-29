declare
=======

Description
------------

A unit testing framework with tiny DSL.

Futures
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
require '../lib/declare'

The Person.new('John') do |john|

  can :name
  can :birth
  is_a Person
  kind_of Object
  
  NOT 'Taro'
  
  The john.name do |name|
    kind_of String
    is_a 'Taro'
    truthy name.kind_of?(String)
    falthy name.match(/[1-9]/)
  end

  The john.birth do
    kind_of Time
  end

end

Declare.report
```

Report

```markdown
Declare report
==============

## "John" ## [mixed.rb:26]

* mixed.rb:28
  Expected: It's equaly value with "Taro" under bidirectical #== method.
  Actual  : false


------------------------------------------------------------------------------
Total
=====

3 scopes, 10 behaviors
pass: 9
fail: 1
```

Requirements
------------

* Ruby 1.9.2 or later

Installation
-------------

```shell
$ gem install declare
```

License
-------

The MIT X License  
Copyright (c) 2012 Kenichi Kamiya  
See the file LICENSE for further details.
