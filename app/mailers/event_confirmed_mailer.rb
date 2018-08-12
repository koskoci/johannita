class EventConfirmedMailer < ApplicationMailer
  def call
    @user = params[:user]
    @event = params[:event]
    mail(to: @user.email, subject: I18n.t('event_confirmed_mailer.subject'))
  end
end