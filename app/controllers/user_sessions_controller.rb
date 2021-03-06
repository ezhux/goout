class UserSessionsController < ApplicationController
  def new
    @title = t(:login)
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
      if @user_session.save
        flash[:notice] = t(:login_successful) 
        redirect_to root_url
      else
        render :action => "new" 
      end
  end

  def destroy
    @user_session = UserSession.find
    @user_session.destroy
        flash[:notice] = t(:logout_successful) 
      redirect_to root_url 
  end
end
