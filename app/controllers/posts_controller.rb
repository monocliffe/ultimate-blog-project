class PostsController < ApplicationController
  before_action :load_post, only: [:show]#, :edit, :destroy, :update]
  before_action :ensure_login, except: [:index]

  def index
    @posts = Post.order(:created_at)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = @current_user
    if @post.save
      redirect_to post_path(@post), alert: 'Post created successfully!'
    else
      render :new
    end
  end

  def show; end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:title, :body)
  end

  def load_post
    @post = Post.find_by(id: params[:id])

    unless @post
      redirect_to posts_path, alert: 'Post Not found!'
    end
  end
end
