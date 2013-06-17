module MultirowCounter
  module Extension
    def multirow_counter(counter_name, options)
      num_rows = options[:rows] || raise(ArgumentError, "You need to specify how many rows will be used eg. :rows => 3")
      class_name = self.name

      assoc = class_name.foreign_key
      table_name = [class_name, counter_name.to_s.camelize].join.tableize

      # define getter method
      getter = lambda do
        ivar_name = "@#{counter_name}"
        if x = instance_variable_get(ivar_name)
          return x
        else
          val = ActiveRecord::Base.connection.select_value <<-SQL
            SELECT IFNULL(SUM(value),0) FROM #{table_name} WHERE #{assoc}=#{self.id}
          SQL
          instance_variable_set(ivar_name, val.to_i)
        end
      end

      define_method(counter_name, &getter)
      define_method("multirow_counter_#{counter_name}", &getter)

      # define increment method
      define_method("new_#{counter_name}!") do |incr = 1|
        ivar_name = "@#{counter_name}"
        if x = instance_variable_get(ivar_name)
          instance_variable_set(ivar_name, x + incr)
        end

        randomly_selected_counter_row = rand(num_rows) + 1

        num_changed = ActiveRecord::Base.connection.update <<-SQL
          UPDATE #{table_name} SET value=value+#{Integer(incr)}
            WHERE #{assoc}=#{self.id} AND counter_id=#{randomly_selected_counter_row}
        SQL

        if num_changed == 0 # row doesn't exist. We create it instead.
          ActiveRecord::Base.connection.execute <<-SQL
            INSERT INTO #{table_name} (#{assoc}, counter_id, value)
              VALUES (#{self.id}, #{randomly_selected_counter_row}, #{Integer(incr)})
              ON DUPLICATE KEY UPDATE value=value+#{Integer(incr)};
          SQL
        end
      end

      define_method("reload_with_#{counter_name}_reset") do
        instance_variable_set("@#{counter_name}", nil)
        send("reload_without_#{counter_name}_reset")
      end

      alias_method_chain :reload, "#{counter_name}_reset".to_sym
    end
  end
end

