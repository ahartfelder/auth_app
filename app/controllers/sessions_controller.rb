class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user.present? && user.authenticate(params[:password])
      if user.confirmed?
        session[:user_id] = user.id
        redirect_to root_path, notice: "Logged in."
      elsif user.created_at + 15.minutes < Time.now
        RegistrationMailer.with(user: user).confirmation.deliver_later
        redirect_to login_path, notice: "A new token has been sent to your email."
      else
        flash.now[:alert] = "You must confirm your email before loggin in."
        render :new, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = "Invalid email or password."
      render :new, status: :unprocessable_entity
    end
  end

  def confirmation
    @user = User.find_signed!(params[:token], purpose: "confirmation")
    if !@user.confirmed?
      @user.activate_user
      flash[:notice] = "Email successfully confirmed."
    else
      flash[:alert] = "Email already confirmed."
    end
    redirect_to login_path
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      flash[:alert] = "Your token has expired. Try again."
      redirect_to login_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, status: :see_other, notice: "Logged out."
  end
end
