class EventCancelledMailer < ApplicationMailer
  def call
    @user = params[:user]
    @event = params[:event]
    mail(to: @user.email, subject: I18n.t('event_cancelled_mailer.subject'))
  end
end
