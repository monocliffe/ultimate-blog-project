set :output, 'log/whenever.log'

every 1.minutes do
  rake 'cd :path && rake post_hard_delete'
end
