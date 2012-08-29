module Declare
  
  CallerEntry = Struct.new :file_name, :line_number, :method_name, :block_level do
    
    class << self
      
      # @param [String] caller_entry
      # @return [CallerEntry]
      # reference: http://doc.ruby-lang.org/ja/1.9.3/class/Kernel.html
      def parse(caller_entry)
        if /\A(.+?):(\d+)(?::in `(.*)')?/ =~ caller_entry
          file_name, line_number, method_name = $1, $2.to_i, $3
          block_level = /block \((\d+) levels\)/ =~ method_name ? $1.to_i : 1
          
          new file_name, line_number, method_name, block_level
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
