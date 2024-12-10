class UserMaiMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mai_mailer.response_readyxcvv.subject
  #
  def response_readyxcvv
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mai_mailer.cvdvs.subject
  #
  def cvdvs
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
