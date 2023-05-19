class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  #ログインページ
  def new
  end

  #ログイン処理
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to login_path
    end
  end
  
  #ログアウト処理
  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end
end
