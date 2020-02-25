namespace :post do
  desc 'delete all discarded tasks over 1 hour old'
  task hard_delete: :environment do
    Post.discarded.each do |post|
      post.delete if post.discarded_at.to_date < (Time.now - 1.hour)
    end
  end
end