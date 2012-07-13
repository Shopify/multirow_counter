# multirow-counter

This is a gem that encapsulates a multi-row counter for SQL. 

## Why?

Typically SQL is not a great place to store a counter that is incremented often. For instance if you're counting the number of visits to a page by incrementing a SQL column and that page gets popular then there's a good chance that the SQL counter will become a benchmark. This is because doing an UPDATE on the row in question locks the row during the course of the UPDATE. So for many concurrent UPDATES there will be lots of lock contention.

## How?

This library addresses the issue with a hack. Rather than having a single row hold the value for a counter it creates multiple rows for one counter and the true value is the sum total of the value from all the related rows. This addresses the issue of lock contention by sending each UPDATE to a random one of the related rows, lowering the chance of lock contention happening.

## Usage

Bring the gem into your project:

``` ruby
gem 'multirow-counter'
```

Generate a new counter for a given model:

``` console
$ rails generate multirow_counter shop version 3
```

This will create the required migration and add the following delcaration to the Shop model:

``` ruby
class Shop < ActiveRecord::Base
  multirow_counter :version, :rows => 3
end
```

Then you can use it like so:

``` ruby
shop = Shop.find(1)
shop.increment_version!
shop.increment_version!
shop.version #=> 2
```

The multirow nature of the counter is hidden behind the interface. You can increment and read the counter as if it were a single column on the model.

## License

MIT

## Notes

table shops
  id

table shop_versions
  id
  shop_id
  counter_id
  value

