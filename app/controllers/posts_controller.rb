class PostsController < ApplicationController
  before_action :load_post, only: [:show, :edit, :update, :destroy]
  before_action :ensure_login, except: [:index, :show]

  def index
    @posts = Post.kept.order(:created_at)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = @current_user
    if @post.save
      flash[:success] = 'Post created successfully!'
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:success] = 'Post updated successfully!'
      redirect_to posts_url
    else
      render :edit
    end
  end

  def soft_delete
    @post.discard
    flash[:alert] = 'Post Removed.'
    redirect_to posts_url
  end

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
      flash[:alert] = 'Post Not found!'
      redirect_to posts_path
    end
  end
end
