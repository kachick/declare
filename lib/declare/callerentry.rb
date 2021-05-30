# coding: us-ascii
# frozen_string_literal: true

module Declare
  CallerEntry = Struct.new(:file_name, :line_number, :method_name, :block_level, keyword_init: true) do
    class << self
      # @param [String] caller_entry
      # @return [CallerEntry]
      # reference: http://doc.ruby-lang.org/ja/1.9.3/class/Kernel.html
      def parse(caller_entry)
        matched = /\A(?<file_name>.+?):(?<line_number>\d+)(?::in `(?<method_name>.*)')?/.match(caller_entry)
        if matched
          # file_name, line_number, method_name = $1, $2.to_i, $3
          block_level = case matched[:method_name]
                        when /block \((\d+) levels\)/
                          Regexp.last_match(1).to_i
                        when /block/
                          1
                        else
                          0
                        end

          new(file_name: matched[:file_name], line_number: Integer(matched[:line_number]), method_name: matched[:method_name], block_level: block_level)
        else
          raise TypeError, caller_entry
        end
      end
    end

    def to_s
      "#{file_name}:#{line_number}"
    end
  end
end
