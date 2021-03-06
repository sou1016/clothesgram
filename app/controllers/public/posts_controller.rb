class Public::PostsController < ApplicationController
  before_action :authenticate_member!, except: [:top, :index, :show]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.member_id = current_member.id
    if @post.save
      redirect_to public_member_path(@post.member.id)
    else
      render :new
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.member_id = current_member.id
    if @post.update(post_params)
      redirect_to public_post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to public_member_path(@post.member.id)
  end


  private

  def post_params
    params.require(:post).permit(:image, :body, :genre_id)
  end
end
