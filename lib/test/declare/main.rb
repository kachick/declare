# Copyright (C) 2012 Kenichi Kamiya


class << self
  
  # @param [String] title
  # @return [void]
  def Declare(title=nil, &block)
    title = title.nil? ? caller.first : title

    ::Test::Declare.new_category(title).instance_exec(&block)
  rescue Exception
    raise ::Test::Declare::UnhandledError, $!.inspect, $!.backtrace
  else
    ::Test::Declare.report
  end

end
