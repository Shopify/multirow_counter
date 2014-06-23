
Gem::Specification.new do |s|
  s.name        = "multirow_counter"
  s.version     = "0.0.3"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jesse Storimer"]
  s.email       = ["jesse@shopify.com"]
  s.homepage    = "http://github.com/Shopify/multirow_counter"
  s.summary     = %q{Encapsulates a multi-row counter for SQL.}
  s.description = %q{Typically SQL is not a great place to store a counter that is incremented often. For instance if you're counting the number of visits to a page by incrementing a SQL column and that page gets popular then there's a good chance that the SQL counter will become a benchmark. This is because doing an UPDATE on the row in question locks the row during the course of the UPDATE. So for many concurrent UPDATES there will be lots of lock contention. This gem helps with that.}

  s.files         = Dir['lib/**/*.rb']
  s.test_files    = Dir['test/**/*_test.rb']

  s.add_runtime_dependency 'activerecord'
  s.add_development_dependency 'mysql2'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'minitest'
end

