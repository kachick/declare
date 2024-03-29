# coding: us-ascii
# frozen_string_literal: true

module Declare
  ScopeSummary = Struct.new(:target, :caller_entry, :nesting_level, keyword_init: true)

  @failures = {}
  @scope_summaries = []
  @pass_counter = 0
  @declare_counter = 0

  class << self
    attr_reader :failures

    def describe(&block)
      BasicScope.new.instance_exec(&block)
    end

    def auto_run
      at_exit do
        $! || report
      end
    end

    # @return [AssertionsScope]
    def new_scope(target, &block)
      AssertionsScope.new(target).instance_exec(target, &block)
    end

    def declared!
      @declare_counter += 1
    end

    def scope!(target, caller_entry)
      @scope_summaries << ScopeSummary.new(target:, caller_entry:, nesting_level: caller_entry.block_level)
    end

    def pass!
      @pass_counter += 1
    end

    def failure!(report)
      @failures[@scope_summaries.last] ||= []
      @failures[@scope_summaries.last] << report
    end

    def failure_count
      @failures.values.flatten.size
    end

    def report
      unless @failures.empty?
        report_detail
        puts '-' * 78
      end

      failure_count = failure_count()
      puts "#{@scope_summaries.length} scopes, #{@declare_counter} assertions, #{failure_count} failures"

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
        puts(lines.map { |l| "* #{l}" })
      end
    end
  end
end
