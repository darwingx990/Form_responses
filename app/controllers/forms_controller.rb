class FormsController < ApplicationController
  before_action :set_form, only: %i[ show edit update destroy ]

  # GET /forms or /forms.json
  def index
    @forms = Form.includes(:response)
  end

  # GET /forms/1 or /forms/1.json
  def show
    @form = Form.find(params[:id])
  end

  # GET /forms/1/edit
  def edit
  end

  # GET /forms/new
  def new
    @form = Form.new
  end

  # POST /forms or /forms.json
  def create
    @form = Form.new(form_params)

    if @form.save
      generate_ai_response(@form)
      redirect_to forms_path, notice: "Form and response created successfully."
    else
      render :new
    end
  end

  # def create
  #   @form = Form.new(form_params)

  #   if @form.processed_in_job
  #     ProcessResponseJob.perform_later(@form.id, @form.name)
  #   else
  #     @form.create_response!(status: "Pending")
  #     openai_service = OpenaiService.new(@form.name)
  #     ai_response= openai_service.call
  #     @form.response.update(ai_response: ai_response, status: "Completed")
  #   end

  #   redirect_to @form, notice:"Form created successfully."
  # end

  # def create
  # if @form.save
  #   if @form.processed_in_job
  #     ProcessFormJob.perform_later(@form)
  #   else
  #     process_form(@form)
  #   end
  #   redirect_to @form, notice:"Form created successfully."
  # else
  #   render :new
  # end


  # PATCH/PUT /forms/1 or /forms/1.json
  def update
    respond_to do |format|
      if @form.update(form_params)
        format.html { redirect_to @form, notice: "Form was successfully updated." }
        format.json { render :show, status: :ok, location: @form }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forms/1 or /forms/1.json
  def destroy
    @form.destroy!

    respond_to do |format|
      format.html { redirect_to forms_path, status: :see_other, notice: "Form was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_form
    @form = Form.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def form_params
    params.require(:form).permit(:name, :description, :processed_in_job)
  end

  def generate_ai_response(form)
    prompt = "Generate a response for the form with name: #{form.name}. Prompt: #{form.description}"
    ai_response = OpenaiService.new(prompt).call

    form.create_response!(
      ai_response: ai_response,
      status: "completed"
    )
  rescue StandardError => e
    form.create_response!(
      ai_response: "Error generating response: #{e.message}",
      status: "failed"
    )
  end
  # def process_form(form)
  #   apiKey=ENV["OPENAI_KEY"]
  #   response = HTTParty.post("https://api.openai.com/v1/forms", body: {prompt: form.name, max_tokens: 50 }.to_json, headers: { "Content-Type" => "application/json", "Authorization" => apiKey})
  #   form.create!(ai_response: response['data'] ['choices'][0]['text'], status: 'completed')
  #   UserMailer.with(form: form).response_ready.deliver_later
  # rescue StandardError => e
  #   form.create_response!(ai_response: e.message, status: 'failed')
  # end
end
