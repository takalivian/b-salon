class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    Post.create(post_params)
  end

  def show
    @post = Post.find(params[:id])
    # @posts = Post.includes(:user)
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

  # def create
  #   @room = Room.create
  #   @entry1 = Entry.create(:room_id => @room.id, :user_id => current_user.id)
  #   @entry2 = Entry.create(:room_id => @room.id, :user_id => @post.user.id)
  #   redirect_to "/rooms/#{@room.id}"
  # end

  private
  def post_params
    params.require(:post).permit(:title, :date, :area_id, :postal, :place, :venue, :capacity, :remarks, :user_id).merge(user_id: current_user.id)
  end

end
