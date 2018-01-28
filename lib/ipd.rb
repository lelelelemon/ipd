require "ipd/version"
require 'ipd/railtie' if defined?(Rails)

module Ipd
  # Your code goes here...
  @files = []
  @times = []
  def self.addElement
      color = ['lightblue','yellow','pink','lightgreen','grey']
      puts @files.length
      if(@files.length > 0)
        for i in 0..(@files.length-1)
            f = @files[i]
            t = @times[i]
            Deface::Override.new(:virtual_path => f, 
               :name => "example-1", 
               :surround => "div", 
               :text => "<div id='div-#{i}' style='background-color: #{color[i]};'><p align='center'><strong>#{f}</strong>: #{t}ms <button id='button-#{i}' onclick='delete()'>Delete</button></p><%= render_original %></div><script>document.getElementById('button-#{i}').addEventListener('click', function(){document.getElementById('div-#{i}').style.display = 'none';;});</script>")
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
        rel_path = payload[:identifier].split("views/")
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
        #Rails.logger.info "#{finished - started} Rendered #{payload[:identifier]}!"
        f = payload[:identifier].split("views/")[1].scan(/[a-z]+\/\S+[erb|haml|slim]/)[0].split('.')[0]
        if(!@files.include?f)
          @files << f 
          @times << (finished - started) * 1000
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

backtrace = Rails.backtrace_cleaner.clean caller

relevant_caller_line = backtrace.detect do |caller_line|
  !caller_line.include?('/initializers/')
end

if relevant_caller_line
  Rails.logger.info("#{ relevant_caller_line.sub("#{ Rails.root }/", '') }")
end     
