require 'rails/generators/active_record/migration'

class MultirowCounterGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  extend ActiveRecord::Generators::Migration

  source_root File.join(File.dirname(__FILE__), 'templates')
  argument :model_name, :type => :string
  argument :counter_name, :type => :string
  argument :number_of_counter_rows

  def create_migration
    migration_template 'multirow_counter_migration.rb', "db/migrate/add_#{counter_name}_counter_to_#{model_name}.rb"
  end

  def inject_code
    inject_into_file "app/models/#{model_name}.rb", :after => '/class <%= model_name.classify %>' do
      "multirow_counter :#{counter_name}, :rows => #{number_of_counter_rows}"
    end
  end
end

