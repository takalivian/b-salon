class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :show]
  # before_action :setting_post, only: [:update, :destroy]

  def index
    @posts = Post.all.order(id: "DESC")
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path, notice: '投稿が送信されました'
    else
      redirect_to new_post_path, notice: '入力してください。'
    end
  end

  def show
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @post.user.id)
    if @post.user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def edit
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to post_path, notice: '更新しました'
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path, notice: '削除しました'
  end

  def search
    @posts = Post.search(params[:keyword]).order(id: "DESC")
    redirect_to action: :index unless user_signed_in?
  end

  private
  def post_params
    params.require(:post).permit(:title, :date, :area_id, :postal, :place, :venue, :capacity, :remarks, :user_id).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  # def setting_post
  #   post = Post.find(params[:id])
  # end

end
