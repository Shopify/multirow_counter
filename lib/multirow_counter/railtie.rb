module MultirowCounter
  class Railtie < Rails::Railtie
    initializer 'multirow-counter extension' do
      ActiveRecord::Base.extend MultirowCounter::Extension
    end

    generators do
      require "generators/multirow_counter_generator"
    end
  end
end

