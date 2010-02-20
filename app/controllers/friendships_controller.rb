class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])   
      if @friendship.save   
        flash[:notice] = t(:added_friend) 
        redirect_to user_path(User.find(params[:friend_id]).username) 
      else   
        flash[:notice] = t(:unable_to_add_friend)   
        redirect_to user_path(params[:friend_id]) 
      end   
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])   
    @friendship.destroy   
    flash[:notice] = t(:removed_friend)   
    redirect_to user_path(current_user.username)   
  end

end
