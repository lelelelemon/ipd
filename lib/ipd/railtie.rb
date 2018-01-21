module Ipd
    class Railtie < Rails::Railtie
        initializer 'ipd' do |app|
            ActiveSupport.on_load :action_controller do 
                puts "on load"
            end
            ActiveSupport.on_load :action_view do
                files = "#{`tail log/development.log`}".scan(/\s[a-z]+\/\S+[erb|haml|slim]\s/)
                puts files
            end
        end
    end
end