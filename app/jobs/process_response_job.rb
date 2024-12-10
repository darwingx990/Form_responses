class ProcessFormJob < ApplicationJob
  queue_as :default

  def perform(form_id, prompt)
    form = Form.find(form_id)
    response=form.create_response!(status: "pending")

    begin
      openai_service = OpenaiService.new(prompt)
      ai_response = openai_service.call
      response.update(ai_response: ai_response, status: "completed")

      # Send email to the user
      UserMailer.response_ready(form).deliver_now
    rescue => e
      response.update(status: "failed")
      Rails.logger.error("Error when proccesing the answer: #{e.message}")
    end
  end
end
