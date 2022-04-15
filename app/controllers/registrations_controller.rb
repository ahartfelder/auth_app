class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Welcome to Authentication App, #{@user.email}!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    Current.user.destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Your account was permanently deleted."
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
