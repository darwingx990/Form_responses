class Response < ApplicationRecord
  belongs_to :form

  STATUSES = %w[pending completed failed].freeze

  validates :status, inclusion: { in: STATUSES }
end
