worker_processes 8
timeout 15
preload_app true

listen "/srv/tmp/sockets/unicorn.sock", :backlog => 2048
pid "/srv/tmp/pids/unicorn.pid"
stderr_path "#{@dir}log/unicorn.log"

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
