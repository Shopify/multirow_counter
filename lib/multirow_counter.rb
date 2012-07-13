module MultirowCounter
  module Extension
    def multirow_counter(name, options)
      create_counter_model(name)

      define_method(name) do
      end
    end

    private
    def create_counter_model(name)
      counter_class = Class.new(ActiveRecord::Base) do
      end

      const_name = [self.name, name.to_s.classify].join
      MultirowCounter.const_set(const_name, counter_class)
    end
  end

  if defined?(::Rails)
    class Railtie < Rails::Railtie
      initializer 'multirow-counter extension' do
        ActiveRecord::Base.extend MultirowCounter::Extension
      end
    end
  end
end


