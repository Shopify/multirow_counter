
Gem::Specification.new do |s|
  s.name        = "multirow-counter"
  s.version     = "0.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jesse Storimer"]
  s.email       = ["jesse@shopify.com"]
  s.homepage    = "http://github.com/Shopify/multirow-counter"
  s.summary     = %q{...}
  s.description = %q{...}

  s.files         = Dir['lib/**/*.rb']
  s.test_files    = Dir['test/**/*_test.rb']

  s.add_runtime_dependency 'activerecord'
  s.add_development_dependency 'mysql2'
end

