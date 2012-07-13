class AddShopVersionsTableMigration < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.integer :id
    end

    shop = Shop.create!

    create_table :shop_versions do |t|
      t.integer :id
      t.integer :shop_id
      t.integer :counter_id
      t.integer :value
    end

    3.times do |num|
      ShopVersion.create!(:shop_id => shop.id, :counter_id => num, :value => 0)
    end
  end
end

