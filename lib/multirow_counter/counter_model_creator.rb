class CounterModelCreator < Struct.new(:counter_name, :class_name)
  def create
    counter_class = Class.new(ActiveRecord::Base)
    const_name = [class_name, counter_name.classify].join
    MultirowCounter.const_set(const_name, counter_class)
  end
end


