# Copyright (C) 2012 Kenichi Kamiya


module Declare

  @unexpected_failures = {}
  @categories = {}
  @failures = {}
  @scope = nil
  @scope_counter, @failure_counter, @pass_counter, @declare_counter = 0, 0, 0, 0
      
  class << self
    
    def unexpected_failure_in_the(scoped, exception, _caller)
      @unexpected_failures[scoped] = [exception, _caller]
    end
    
    def new_category(title)
      title = title.to_s
      raise DupulicatedCategoryError if @categories.has_key? title

      @categories[title] = Category.new
    end
    
    def declared!
      @declare_counter += 1
    end

    def scope!(scope)
      @scope_counter += 1
      @scope = scope
    end

    def pass!
      @pass_counter += 1
    end
    
    def failure!(report)
      @failure_counter += 1
      @failures[@scope] ||= []
      @failures[@scope] << report
    end

    def report
      @failures.each_pair do |scope, text|
        puts "# #{scope}", text, nil
      end
      
      puts '-' * 76
      puts "#{@categories.length} categorized, #{@scope_counter} scoped, #{@declare_counter} declared"
      puts " Unexpected Failers: #{@unexpected_failures.inspect}" unless @unexpected_failures.empty?
      puts "    pass: #{@pass_counter}"
      puts "    fail: #{@failure_counter}"
    end
    
  end

end