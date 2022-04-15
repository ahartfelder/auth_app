class PasswordsResetController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email].downcase)
    if @user.present?
      PasswordMailer.with(user: @user).reset.deliver_later
    end
    redirect_to login_path, notice: "Email sent. Please check your email to proceed."
  end

  def edit
    @user = User.find_signed!(params[:token], purpose: "password_reset")
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to login_path, alert: "Your token has expired. Try again."
  end

  def update
    @user = User.find_signed!(params[:token], purpose: "password_reset")
    if @user.update(password_params)
      redirect_to login_path, notice: "Password was reset successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
