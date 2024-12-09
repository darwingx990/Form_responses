class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.response_ready.subject

  default from: 'notifications@example.com'

  def response_ready
    @form = params[:form]
    mail(to: 'user@example.com', subject: 'Your response is ready')
  end
end

