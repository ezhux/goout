class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html 
    end
  end

  def show
    find_user(params)
    @title = t(:user_profile, :username => @user.username)
    if @user
      @user.spec ||= Spec.new
      @spec = @user.spec
      @posts = @user.posts
      @activities = @user.activities

      respond_to do |format|
        format.html 
      end
    else 
      flash[:notice] = t(:no_such_user)
        redirect_to users_path
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    @title = t(:edit_user) 
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:notice] = 'User was successfully created.'
        format.html { redirect_to(@user) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @user = User.find(params[:id])
    @avatar = Avatar.new(:uploaded_data => params[:avatar_file])
    @service = UserService.new(@user, @avatar)

    respond_to do |format|
      #if we have an uploaded avatar
      if params[:avatar_file]
        if @service.update_attributes(params[:user], params[:avatar_file])
          flash[:notice] = t(:user_was_successfully_updated) 
          format.html { redirect_to(@user) }
        else
          @avatar = @service.avatar
          format.html { render :action => "edit" }
        end
      #no avatar file
      else
        if @user.update_attributes(params[:user])
          flash[:notice] =  t(:user_was_successfully_updated) 
          format.html { redirect_to(user_path(@user)) }
        else
          format.html { render :action => "edit" }
        end
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to(users_url) }
    end
  end
 
  private

end
