# @param [String] title
# @return [void]
#~ def Declare(title=nil, &block)
  #~ title = title.nil? ? caller.first : title

  #~ ::Declare.new_category(title).instance_exec(&block)
#~ rescue Exception
  #~ raise ::Declare::UnhandledError, $!.inspect, $!.backtrace
#~ else
  #~ ::Declare.report
  #~ exit ::Declare.failures.length
#~ end

module Kernel

  private
  
  alias_method :_original_caller, :caller

  def _declare_called_from(level=0)
    ::Declare::CallerEntry.parse _original_caller[1 + level]
  end

  def The(target, &block)
    ::Declare.scope! target, _declare_called_from
    ::Declare.new_scope(target, &block)
  end

end