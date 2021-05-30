# coding: us-ascii
# frozen_string_literal: true

module Declare
  @auto_run = false
  @unexpected_failures = {}
  @failures = {}
  @scope_summaries = []
  @pass_counter = 0
  @declare_counter = 0

  class << self
    attr_reader :failures

    ScopeSummary = Struct.new(:target, :description, :caller_entry, :nesting_level)

    def auto_run
      @auto_run = true
      at_exit do
        $! || report
      end
    end

    def auto_run?
      @auto_run
    end

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
        report_detail
        puts '-' * 78
      end

      failure_count = @failures.values.flatten.length
      puts "#{@scope_summaries.length} scopes, #{@declare_counter} assertions, #{failure_count} failures"
      puts " Unexpected Failers: #{@unexpected_failures.inspect}" unless @unexpected_failures.empty?

      exit(failure_count)
    end

    private

    def report_detail
      top_header = 'Detail testing report'
      puts top_header
      puts '=' * top_header.length, nil

      @failures.each_pair do |scope, lines|
        header = (
          case scope.nesting_level
          when 0
            obj_header = "#{scope.target.inspect} [#{scope.caller_entry.file_name}:#{scope.caller_entry.line_number}]"
            "#{obj_header}\n#{'-' * obj_header.length}"
          else
            "###{'#' * scope.nesting_level} #{scope.target.inspect} ###{'#' * scope.nesting_level} [#{scope.caller_entry.file_name}:#{scope.caller_entry.line_number}]"
          end
        )
        puts header, nil
        puts lines.map { |l| "* #{l}" }
      end
    end
  end
end
