require "ipd/version"
require 'ipd/railtie' if defined?(Rails)

module Ipd
  # Your code goes here...
  @files = []
  @times = []
  def self.addElement
      color = ['lightblue','yellow','pink','lightgreen','grey']
      render_events = []
      query_events = []
"""
      ActiveSupport::Notifications.subscribe('render_template.action_view') do |name, started, finished, unique_id, payload, children|
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
"""
      ActiveSupport::Notifications.subscribe('render_template.action_view') do |*args|
        #Rails.logger.info "#{finished - started} Rendered #{payload[:identifier]} #{@files.length} Children #{children}"
      	event = ActiveSupport::Notifications::Event.new(*args)
      	render_events << event
      end
      ActiveSupport::Notifications.subscribe('render_partial.action_view') do |*args|
      	event = ActiveSupport::Notifications::Event.new(*args)
      	render_events << event
      end
      ActiveSupport::Notifications.subscribe('sql.active_record') do |*args|
      	event = ActiveSupport::Notifications::Event.new(*args)
      	query_events << event
      end
      render_events.each do |re|
        puts re.name
        query_events.each do|qe|
          puts qe.name
          if(re.parent_of?(qe)) 
            Rails.logger.info "Parent #{re.name} -> #{qe.name}"
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


