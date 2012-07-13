require 'multirow_counter/extension'
require 'multirow_counter/counter_model_creator'

module MultirowCounter
  if defined?(::Rails)
    class Railtie < Rails::Railtie
      initializer 'multirow-counter extension' do
        ActiveRecord::Base.extend MultirowCounter::Extension
      end
    end
  end
end


