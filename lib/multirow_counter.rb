module MultirowCounter
  module Extension
    def multirow_counter(counter_name, options)
      class_name = self.name
      num_rows = options[:rows] || raise(ArgumentError, "You need to specify how many rows will be used eg. :rows => 3")

      builder = Builder.new(counter_name.to_s, class_name, options)
      const = builder.create_counter_model

      # define getter method
      define_method(counter_name) do
        const.where(class_name.foreign_key => id).sum(:value)
      end

      # define increment method
#      define_method("increment_#{counter_name}") do
#        const.where(class_name.foreign_key => id).where("counter_id = FLOOR(RAND() * #{num_rows}) + 1").limit(1).update_all("value = value+1")
#      end

      define_method("increment_#{counter_name}") do
        const.where(class_name.foreign_key => id).where(:counter_id => rand(3)+1).limit(1).update_all("value = value+1")
      end

    end
  end

  class Builder < Struct.new(:counter_name, :class_name, :options)
    def create_counter_model
      counter_class = Class.new(ActiveRecord::Base) do
      end

      const_name = [class_name, counter_name.classify].join
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


