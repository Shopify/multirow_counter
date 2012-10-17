class Add<%= counter_name.classify %>CounterTo<%= model_name.classify %> < ActiveRecord::Migration

  def self.up
    execute <<-SQL
      CREATE TABLE <%= [model_name, counter_name].join('_').tableize %> (
        <%= model_name %>_id INT     NOT NULL,
        counter_id           TINYINT NOT NULL,
        value                INT     NOT NULL,
        PRIMARY KEY (<%= model_name %>_id, counter_id)
      )
    SQL
  end

  def self.down
    drop_table :<%= [model_name, counter_name].join('_').tableize %>
  end
end

