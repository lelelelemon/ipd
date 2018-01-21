require "ipd/version"
require 'ipd/railtie' if defined?(Rails)

module Ipd
  # Your code goes here...
  def self.addElement()
     files = "#{`tail log/development.log`}".scan(/\s[a-z]+\/\S+[erb|haml|slim]\s/)
  end
end
