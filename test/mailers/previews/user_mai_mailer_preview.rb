# Preview all emails at http://localhost:3000/rails/mailers/user_mai_mailer
class UserMaiMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/user_mai_mailer/response_ready
  def response_ready
    UserMaiMailer.response_ready
  end
end
