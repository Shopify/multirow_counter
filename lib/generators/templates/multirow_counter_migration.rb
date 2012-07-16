class Add<%= counter_name.classify %>CounterTo<%= model_name.classify %> < ActiveRecord::Migration

  def self.up
    create_table :<%= [model_name, counter_name].join('_').tableize %> do |t|
      t.integer :id
      t.integer :<%= model_name %>_id
      t.integer :counter_id
      t.integer :value
    end

    add_index :<%= [model_name, counter_name].join('_').tableize %>, :<%= model_name %>_id

    # You may want to consider moving this into a background task if it takes too long
    <%= model_name.classify %>.find_each do |<%= model_name %>|
      1.upto(<%= number_of_counter_rows %>) do |num|
        MultirowCounter::<%= model_name.classify %><%= counter_name.classify %>.create! do |row|
          row.<%= model_name %>_id = <%= model_name %>.id
          row.counter_id = num
          row.value = 0
        end
      end
    end
  end

  def self.down
    drop_table :<%= [model_name, counter_name].join('_').tableize %>
  end
end

