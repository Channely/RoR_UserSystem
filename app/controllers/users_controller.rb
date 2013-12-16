class UsersController < ApplicationController
  before_action :signed_in_user_or_admin, only: [:edit, :update, :show]
  before_action :correct_user,            only: [:edit, :update, :show]
  before_action :admin_user,              only: [:index, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      unless admin?
        sign_in @user
        flash[:success] = "欢迎尊敬的"+@user.name+"来到活动通，祝您使用愉快。"
        redirect_to @user
      else
        flash[:success] = "用户"+@user.name+"创建成功!"
        redirect_to users_path
      end
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_update_params)
      flash[:success] = "资料已更新."
      unless admin?
        redirect_to @user
      else
        redirect_to users_path
      end
    else
      render 'edit'
    end
  end

  def index
    @users = User.all.sort
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "用户已删除."
    redirect_to users_url
  end


  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :question, :answer, :password_confirmation)
    end

    def user_update_params
      params.require(:user).permit(:name, :password, :question, :answer, :password_confirmation)
    end

    def signed_in_user_or_admin
      unless signed_in? || admin?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user) || admin?
    end

    def admin_user
      redirect_to(root_path) unless admin?
    end
end
