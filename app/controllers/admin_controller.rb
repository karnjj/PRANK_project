class AdminController < ApplicationController
  before_action :check_permission

  def user
    @users = User.all
  end

  def user_show
    @user = User.find(params[:id].to_i)
  end

  def user_destroy
    a = User.find(params[:id].to_i)
    a.destroy()
    redirect_to :controller => "admin", :action => "user"
  end

  def user_edit
    @user = User.find(params[:id].to_i)
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        redirect_to :controller => "admin", :action => "user"
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :user_type, :password, :lock_version)
  end

  def check_permission
    if (is_authen? && is_admin?)
      session[:authen] = session[:authen]
    else
      flash[:notice] = "ไม่มีสิทธิเข้าถึง"
      redirect_to :controller => "main", :action => "main"
    end
  end
end
