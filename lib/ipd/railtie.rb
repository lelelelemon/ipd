module Ipd
    class Railtie < Rails::Railtie
        initializer 'ipd' do |app|
            ActiveSupport.on_load :action_controller do 
            end
            ActiveSupport.on_load :action_view do
            end
        end
    end
end