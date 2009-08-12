require 'logger'
require 'benchmark'

class Logger
  
  def self.current
    @logger
  end
  
  def self.current=(logger)
    @logger = logger
  end

end

class RequestAwareLogger < Logger
    
  
  def intend
    @intend = true
    yield
  ensure 
    @intend = false
  end
  
  
  def info_with_time(msg)
    result = nil
    rm = Benchmark.realtime { result = yield }
    info msg + " [%.3fs]" % [rm]
    result
  end
  
  [:info, :warn, :error].each do |level|
    define_method(level) do |msg|
      @intend ? super("  " + msg) : super
    end
  end
  
  
end