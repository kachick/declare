module Declare

  @unexpected_failures = {}
  @failures = {}
  @scope_summaries = []
  @pass_counter = 0
  @declare_counter = 0
      
  class << self
    
    attr_reader :failures
    
    ScopeSummary = Struct.new :target, :description, :caller_entry, :nesting_level
    
    def unexpected_failure_in_the(scoped, exception, _caller)
      @unexpected_failures[scoped] = [exception, _caller]
    end
    
    def new_scope(target, &block)
      Scope.new(target).instance_exec(target, &block)
    end
    
    def declared!
      @declare_counter += 1
    end

    def scope!(target, caller_entry, description=nil)
      @scope_summaries << ScopeSummary.new(target, description, caller_entry, caller_entry.block_level)
    end

    def pass!
      @pass_counter += 1
    end
    
    def failure!(report)
      @failures[@scope_summaries.last] ||= []
      @failures[@scope_summaries.last] << report
    end

    def report
      unless @failures.empty?
        header = 'Declare report'
        puts header
        puts '=' * header.length
        puts

        @failures.each_pair do |scope, lines|
          puts "##{'#' * scope.nesting_level} #{scope.target.inspect} ##{'#' * scope.nesting_level} [#{scope.caller_entry.file_name}:#{scope.caller_entry.line_number}]"
          puts
          puts lines.map{|l|"* #{l}"}
          puts
        end
        
        puts '-' * 78
      end

      puts "#{@scope_summaries.length} scopes, #{@declare_counter} behaviors"
      puts " Unexpected Failers: #{@unexpected_failures.inspect}" unless @unexpected_failures.empty?
      puts "    pass: #{@pass_counter}"
      puts "    fail: #{@failures.values.flatten.length}"
      
      exit @failures.length
    end
    
  end

end