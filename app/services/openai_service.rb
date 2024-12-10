require "openai"

class OpenaiService
  def initialize(prompt)
    @prompt = prompt
    @client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_KEY"))
  end

  def call
    response = @client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [
          {
            role: "system", content: "You are a helpful assistant."
          },
          {
            role: "user", content: @prompt
          }
        ],
        temperature: 0.7,
        max_completion_tokens: 100
      }
    )
    response.dig "choices", 0, "message", "content"

    # self.class.post('/text-davinci-003/completions', {
    #   body: {

    #     prompt: @prompt,
    #     max_tokens: 100,
    #     temperature: 0.7
    #   }.to_json,
    #   headers: {
    #     'Content-Type' => 'application/json',
    #     'Authorization' => "Bearer #{@api_key}"
    #   }
    # })

    # if response.success?
    #   return response.parsed_response['choices'].first['text']
    # else
    #   raise "Error in OpenAI API: #{response.code} - #{response.message}"
    # end
  rescue StandardError => e
    raise "Error processing the request: #{e.message}"
  end
end
