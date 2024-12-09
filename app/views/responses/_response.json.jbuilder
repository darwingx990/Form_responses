json.extract! response, :id, :form_id, :ai_response, :status, :created_at, :updated_at
json.url response_url(response, format: :json)
