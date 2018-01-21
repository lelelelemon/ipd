require "ipd/version"
require 'ipd/railtie' if defined?(Rails)

module Ipd
  # Your code goes here...
  def self.addElement
      puts "add Element"
      lines = "#{`tail log/development.log`}".split("\n")
      files = []
      times = []
      for l in lines
        # match the template file and the time cost on it
        f = l.scan(/\s[a-z]+\/\S+[erb|haml|slim]\s/)
        t = l.match(/[0-9\.]+ms/)
        if f.length > 0 and t.length > 0
          files.push(f[0].gsub(/\s+/, "").split('.')[0])
          times.push(t[0])
        end 
      end
      color = ['lightblue','yellow','pink','red','green','grey']
      index = 0
      for f in files
        puts f
        # if the template doesn't start from an div, then this surrounding doens't work
        Deface::Override.new(:virtual_path => f, 
                       :name => "example-1", 
                       :surround => "div", 
                       :text => "<div style='background-color: #{color[index]};'><p>#{times[index]}</p><%= render_original %></div>")
        
        index = index + 1 
      end
  end
end

if defined?(Rails::Railtie)
  require 'ipd/railtie'
elsif defined?(Rails::Initializer)
  raise "ipd 3.0 is not compatible with Rails 2.3 or older"
end
