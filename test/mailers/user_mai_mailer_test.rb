require "test_helper"

class UserMaiMailerTest < ActionMailer::TestCase
  test "response_ready" do
    mail = UserMaiMailer.response_ready
    assert_equal "Response ready", mail.subject
    assert_equal [ "to@example.org" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
