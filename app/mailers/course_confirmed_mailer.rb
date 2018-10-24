class CourseConfirmedMailer < ApplicationMailer
  def call
    @user = params[:user]
    @event = params[:event]
    mail(to: "#{@user.name} <#{@user.email}>", subject: I18n.t('event_confirmed_mailer.subject'))
  end
end
