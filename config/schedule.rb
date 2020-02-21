set :environment, 'development'
set :output, 'log/whenever.log'

every 1.minute do
  rake 'post:hard_delete', environment: 'development'
end
