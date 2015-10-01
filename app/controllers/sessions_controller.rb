class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    if !current_user.admin?
    sign_out
    redirect_to root_url
    else
      user = User.find_by(email: params[:session][:email].downcase)
      redirect_to user
    end
  end
end
