require 'listen'
require 'pathname'

Puppet::Type.type(:monitor_log).provide(:default) do
  def match
  end

  def match=(value)
    fail("monitoring log #{@resource[:path]} for #{value} timeout in #{@resource[:timeout]} seconds.")
  end

  def sleep_break(seconds=@resource[:timeout])
    while (seconds > 0)
      sleep(1)
      seconds -= 1
      break if @match
    end
  end

  def monitor
    path = Pathname.new(@resource[:path])

    dirname = path.dirname
    basename = path.basename

    match = Regexp.new(@resource[:match])

    log = File.open(path, 'r')

    listen = Listen.to(dirname, only: /^#{basename}$/) do |m, a, r|
      data = log.read
      return if @match = data =~ match
    end

    @match = log.read =~ match

    if @match
      return true
    else
      listen.start
      sleep_break
    end

    return @match
  ensure
    log.close if log
  end
end
