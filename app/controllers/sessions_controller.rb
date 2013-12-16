# encoding: utf-8
class SessionsController < ApplicationController

  def new
  end

  def show
    @user = User.find(params[:id])
    cookies.permanent[:id] = params[:id]
  end

  def check
    user = User.find_by(id: cookies[:id])
    if user[:answer] == params[:answer][:user_answer]
      sign_in user
      cookies.delete(:id)
      flash[:success] = "欢迎尊敬的"+user.name+"来到活动通,祝您使用愉快."
      redirect_back_or user
    else
      cookies.delete(:id)
      flash[:danger] = '错误.'
      redirect_to session_path(user[:id]), method: :get
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if params[:commit] == '忘记密码'
      if user
        redirect_to session_path(user[:id])
      else
        flash.now[:danger] = '请输入正确的邮箱.'
        render 'new'
      end
    elsif params[:commit] == ' 确 认 '
      if user && user[:password]==params[:session][:password]
        sign_in user
        flash[:success] = "欢迎尊敬的"+user.name+"来到活动通,祝您使用愉快."
        redirect_back_or user
      else
        flash.now[:danger] = '邮箱或密码错误.'
        render 'new'
      end
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end


end
