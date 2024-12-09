class ProcessFormJob < ApplicationJob
  queue_as :default

  def perform(form)
    response = HTTParty.post("https://api.openai.com/v1/your-endpoint", body: {input: form.name}, headers: {"Authorization" => "Bearer YOUR_API_KEY"})
    form.create_response!(ai_response: response['data'], status: 'completed')
    UserMailer.with(form: form).response_ready.deliver_later
  rescue StandardError => e
    form.create_response!(ai_response: e.message, status: 'failed')
  end
end
