# Copyright (C) 2012 Kenichi Kamiya


module Declare

  @unexpected_failures = {}
  @categories = {}
  @failures = {}
  @scope = nil
  @scope_counter, @pass_counter, @declare_counter = 0, 0, 0, 0
      
  class << self
    
    def unexpected_failure_in_the(scoped, exception, _caller)
      @unexpected_failures[scoped] = [exception, _caller]
    end
    
    def new_category(title)
      title = title.to_s
      raise DupulicatedCategoryError if @categories.has_key? title

      @categories[title] = DSL::Basic.new
    end
    
    def declared!
      @declare_counter += 1
    end

    def scope!(scope, _caller)
      @scope_counter += 1
      @scope = "#{scope.inspect} (#{_caller.slice(/\A(.+?:\d+)/, 1)})"
    end

    def pass!
      @pass_counter += 1
    end
    
    def failure!(report)
      @failures[@scope] ||= []
      @failures[@scope] << report
    end

    def report
      unless @failures.empty?
        puts '# Below points are not satisfied some conditions.'
        puts

        @failures.each_pair do |scope, lines|
          puts "## #{scope.inspect}"

          lines.each do |line|
            puts "  * #{line}"
          end
          puts
        end
        
        puts '-' * 76
      end

      puts "#{@categories.length} categorizies, #{@scope_counter} scopes, #{@declare_counter} behaviors"
      puts " Unexpected Failers: #{@unexpected_failures.inspect}" unless @unexpected_failures.empty?
      puts "    pass: #{@pass_counter}"
      puts "    fail: #{@failures.values.flatten.length}"
    end
    
  end

end