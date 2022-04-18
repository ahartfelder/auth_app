class PasswordsController < ApplicationController
  before_action :require_user_logged_in!
  
  def edit
  end

  def update
    @user = Current.user
    if @user.authenticate(params[:user][:current_password])
      if @user.update(password_params)
        redirect_to root_path, notice: "Password updated."
      else
        render :edit, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = "Invalid password."
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
