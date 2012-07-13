module MultirowCounter
  class Railtie < Rails::Railtie
    initializer 'multirow-counter extension' do
      ActiveRecord::Base.extend MultirowCounter::Extension
    end
  end
end

