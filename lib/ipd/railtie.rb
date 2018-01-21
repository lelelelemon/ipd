module Ipd
    class Railtie < Rails::Railtie
        initializer 'ipd' do |app|
            ActiveSupport.on_load :action_controller do 
                puts "on load"
            end
        end
    end
end