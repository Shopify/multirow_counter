require 'bundler/setup'
require 'minitest/autorun'
require 'active_record'
require 'multirow_counter'

ActiveRecord::Base.extend MultirowCounter::Extension
class Shop < ActiveRecord::Base
  multirow_counter :version, :rows => 3
  # try adding a second counter
end

ActiveRecord::Base.establish_connection(:adapter => 'mysql2', :database => 'counters')

class MiniTest::Unit::TestCase
  def reset_tables
    ActiveRecord::Base.connection.create_table :shops, :force => true do |t|
      t.integer :id
    end

    @shop = Shop.create!

    ActiveRecord::Base.connection.create_table :shop_versions, :force => true do |t|
      t.integer :id
      t.integer :shop_id
      t.integer :counter_id
      t.integer :value
    end

    1.upto(3) do |num|
      MultirowCounter::ShopVersion.create!(:shop_id => @shop.id, :counter_id => num, :value => 0)
    end

  end
end

