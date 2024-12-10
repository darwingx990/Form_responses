class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.response_ready.subject
  #

  default from: 'notifications@ddyalas.com'

  def response_ready(user_email)
    @user_email= user_email
    @form = params[:form]
    mail(to: 'darwingx990@hotmail.com', subject: 'Your answer is ready.')
  end
end
