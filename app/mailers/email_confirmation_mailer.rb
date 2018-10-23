class EmailConfirmationMailer < ApplicationMailer
  def call
    @user = params[:user]
    mail(to: "#{@user.name} <#{@user.email}>", subject: I18n.t('email_confirmation_mailer.subject'))
  end
end
