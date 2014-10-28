require 'puppet/util'

Puppet::Type.newtype(:monitor_log) do
  newparam(:name, :namevar => true) do
  end

  newparam(:path) do
    desc "log file path"
    validate do |value|
      raise(ArgumentError, "Must provide absolute path: #{value}") unless Puppet::Util.absolute_path? value
    end
  end

  newproperty(:match) do
    desc "regex to match"

    def insync?(is)
      self.provider.monitor
    end
  end

  newparam(:timeout) do
    desc "log monitor timeout"
    defaultto(60)
    munge do |value|
      Integer(value)
    end
  end
end
