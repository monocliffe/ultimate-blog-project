class PostSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at, :user, :title, :rich_body

  def rich_body
    puts @object.inspect
    @object.body.to_s
  end
end
