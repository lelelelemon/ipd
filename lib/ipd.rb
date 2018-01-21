require "ipd/version"
require 'ipd/railtie' if defined?(Rails)

module Ipd
  # Your code goes here...
  def self.addElement
      puts "add Element"
      files = "#{`tail log/development.log`}".scan(/\s[a-z]+\/\S+[erb|haml|slim]\s/)
      color = ['lightblue','yellow','pink','blue','green']
      index = 0
      for f in files
        f = f.gsub(/\s+/, "").split('.')[0]
        puts f
        Deface::Override.new(:virtual_path => f, 
                       :name => "example-1", 
                       :surround => "div", 
                       :text => "<div style='background-color: #{color[index]};'><%= render_original %></div>")
        
        index = index + 1 
      end
  end
end

if defined?(Rails::Railtie)
  require 'ipd/railtie'
elsif defined?(Rails::Initializer)
  raise "ipd 3.0 is not compatible with Rails 2.3 or older"
end
