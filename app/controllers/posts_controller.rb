# Posts Controller
class PostsController < ApplicationController
  before_action :load_post, only: [:show, :edit, :update, :destroy, :restore]
  before_action :ensure_login, except: [:index, :show]

  def index
    @posts = Post.kept.order(:created_at)

    respond_to do |format|
      format.html { render :index}
      format.json { render json: @posts, each_serializer: PostSerializer }
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = @current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), flash: { success: 'Post created successfully!'} }
        format.json { render :show, status: :created, location: post_url(@post) }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    respond_to do |format|
      format.html { render :show}
      format.json { render json: @post, each_serializer: PostSerializer }
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to posts_url, flash: { success: 'Post updated successfully!' } }
        format.json { render :show, status: :ok, location: posts_url }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.discard

    respond_to do |format|
      format.html { redirect_to posts_url, flash: { alert: "Post Removed. #{view_context.link_to('Undo', restore_post_path(@post))}".html_safe} }
      format.json { head :no_content }
    end
  end

  def restore
    @post.undiscard
    flash[:success] = 'Post recovered successfully!'
    redirect_to post_path(@post)
  end
  helper_method :restore

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

    flash[:alert] = 'Post Not found!' if @post.nil?

    redirect_to posts_path if @post.nil?
  end
end
