class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @messages = Message.all.order(created_at: :desc)
    @currentEntries = current_user.entries
    myRoomIds = []
  
    @currentEntries.each do |entry|
      myRoomIds << entry.room.id
    end
  
    @anotherEntries = Entry.where(room_id: myRoomIds).where('user_id != ?',current_user)
  end

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(params.require(:message).permit(:user_id, :content, :room_id).merge(user_id: current_user.id))
      redirect_to "/rooms/#{@message.room_id}"
    else
      redirect_back(fallback_location: root_path)
    end
  end
end