module MultirowCounter
  module Extension
    def multirow_counter(counter_name, options)
      num_rows = options[:rows] || raise(ArgumentError, "You need to specify how many rows will be used eg. :rows => 3")
      class_name = self.name

      creator = CounterModelCreator.new(counter_name.to_s, class_name)
      const = creator.create

      # define getter method
      getter = lambda do
        counter_relation = const.where(class_name.foreign_key => id)
        counter_relation.sum(:value)
      end

      define_method(counter_name, &getter)
      define_method("multirow_counter_#{counter_name}", &getter)

      # define increment method
      define_method("increment_#{counter_name}") do |incr = 1|
        counter_relation = const.where(class_name.foreign_key => id)
        randomly_selected_counter_row = rand(num_rows) + 1

        counter_relation.where(:counter_id => randomly_selected_counter_row).limit(1).update_all("value = value+#{Integer(incr)}")
      end
    end
  end
end

