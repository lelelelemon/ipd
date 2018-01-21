require "ipd/version"
require 'ipd/railtie' if defined?(Rails)

module Ipd
  # Your code goes here...
  def self.addElement
      puts "add Element"
      files = []
      times = []
            
      ActiveSupport::Notifications.subscribe('render_template.action_view') do |name, started, finished, unique_id, payload|
        # your own custom stuff
        Rails.logger.info "#{finished - started} Rendered #{payload[:identifier]}!"
        f = payload[:identifier].split("views/")[1].scan(/[a-z]+\/\S+[erb|haml|slim]/)[0].split('.')[0]
        files << f
        times << (finished - started) * 1000
        
      end
      ActiveSupport::Notifications.subscribe('render_partial.action_view') do |name, started, finished, unique_id, payload|
        # your own custom stuff
        #Rails.logger.info "#{finished - started} Rendered #{payload[:identifier]}!"
        f = payload[:identifier].split("views/")[1].scan(/[a-z]+\/\S+[erb|haml|slim]/)[0].split('.')[0]
        files << f
        times << (finished - started) * 1000
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

