class RegistrationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.registration_mailer.confirmation.subject
  #
  def confirmation
    @token = params[:user].signed_id(purpose: "confirmation", expires_in: 5.minutes)

    mail to: params[:user].email, subject: "[Auth App] Confirmation Email"
  end
end
