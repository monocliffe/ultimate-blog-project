class PostsController < ApplicationController
  before_action :load_post, only: [:show, :edit, :update, :destroy]
  before_action :ensure_login, except: [:index, :show]

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
      redirect_to post_path(@post), notice: 'Post created successfully!'
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to posts_url, notice: 'Post updated successfully!'
    else
      render :edit
    end
  end

  def delete; end

  def post_summary(post)
    ActionController::Base.helpers.strip_tags(post.body.to_s.truncate(300))
  end
  helper_method :post_summary

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
