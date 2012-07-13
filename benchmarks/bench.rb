require 'benchmark'
require 'thread'
require 'mysql2'

CONCURRENCY = 100
ITERATIONS = 100

def query(sql)
  ts = []

  CONCURRENCY.times do
    ts << Thread.new do
      client = Mysql2::Client.new(:host => "localhost", :username => "root")
      client.query "USE counters;"

      ITERATIONS.times do
        client.query(sql)
      end
    end
  end

  ts.each(&:join)
end

Benchmark.bmbm do |x|
  x.report("single row") { query("UPDATE cache_versions 
                                  SET value=value+1 
                                  WHERE shop_id=1;") }
  x.report("3 rows") { query("UPDATE cache_versions
                              SET value=value+1
                              WHERE shop_id=2
                              AND counter_id = FLOOR(RAND() * 3) + 1;") }

  x.report("10 rows") { query("UPDATE cache_versions
                                SET value=value+1
                                WHERE shop_id=3
                                AND counter_id = FLOOR(RAND() * 10) + 1;") }
end

