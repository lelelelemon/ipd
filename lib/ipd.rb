require "ipd/version"
require 'ipd/railtie' if defined?(Rails)
require "ipd/engine"
module Ipd
  # Your code goes here...
  @files = []
  @times = []
  def self.addElement
      color = ['#FFE5CC','#FFCC99','#FFB266','#FF9933','#CC6600']
      puts @files.length
      #cost = open('cost.txt', 'r')
      cost = ['', 'blogs/show.html.erb span#user-num 2.3', 'blogs/show.html.erb span#blog-num 64.4', 'blogs/_blog.html.erb div#blogs 224.8', 'blogs/_user.html.erb div#users 58.3', 'blogs/_blog.html.erb div#test XXX']
      i = 0
      for c in cost
        record = c.split(' ')
        if record.length != 3
          next
        end
        f = record[0].scan(/[a-z]+\/\S+[erb|haml|slim]/)[0].split('.')[0]
        id = record[1]
        ip = record[1].scan(/#.*/)[0]
        t = record[2]            
        Deface::Override.new(:virtual_path => f, 
               :name => "example-1", 
               :surround => id, 
               :text => "<div id='div-#{i}' style='background-color: #{color[i]};'><span align='center'><strong>#{f}</strong>: #{t}ms <button id='button-#{i}' data-toggle='popover' onclick='delete()'>Delete</button></span><%= render_original %></div><script>$('#{ip}').popover();document.getElementById('button-#{i}').addEventListener('click', function(){document.getElementById('div-#{i}').style.display = 'none';;});</script>")
        i += 1
      end
      if(@files.length > 0)
        for i in 0..(@files.length-1)
            f = @files[i]
            t = @times[i]
            # Deface::Override.new(:virtual_path => f, 
            #   :name => "example-1", 
            #   :surround => "div", 
            #   :text => "<div id='div-#{i}' style='background-color: #{color[i]};'><p align='center'><strong>#{f}</strong>: #{t}ms <button id='button-#{i}' onclick='delete()'>Delete</button></p><%= render_original %></div><script>document.getElementById('button-#{i}').addEventListener('click', function(){document.getElementById('div-#{i}').style.display = 'none';;});</script>")
        end
              
        @files = []
        @times = []
        return
      end 
      ActiveSupport::Notifications.subscribe('render_template.action_view') do |name, started, finished, unique_id, payload|
        #Rails.logger.info "#{finished - started} Rendered #{payload[:identifier]} #{@files.length} !"
        for i in 0..(@files.length-1)
          f = @files[i]
          t = @times[i]
        end 
        rel_path = payload[:identifier].split('views/')
        if rel_path.length >= 2
          f = rel_path[1].scan(/[a-z]+\/\S+[erb|haml|slim]/)[0].split('.')[0]
          if(!@files.include?f)
            @files << f 
            t = (finished - started) * 1000
            @times << t
              
          end
        end
      end
      ActiveSupport::Notifications.subscribe('render_partial.action_view') do |name, started, finished, unique_id, payload|
        # your own custom stuff
        
        rel_path = payload[:identifier].split('views/')
        if rel_path.length >= 2
          f = rel_path[1].scan(/[a-z]+\/\S+[erb|haml|slim]/)[0].split('.')[0]
          if(!@files.include?f)
            @files << f 
            t = (finished - started) * 1000
            @times << t
              
          end
        end
      end
    
      ''
  end
end

if defined?(Rails::Railtie)
  require 'ipd/railtie'
elsif defined?(Rails::Initializer)
  raise "ipd 3.0 is not compatible with Rails 2.3 or older"
end

puts "Add Element"