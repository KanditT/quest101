# frozen_string_literal: true

class Quest < ApplicationRecord
  validates :name, presence: true

  after_initialize :set_default_status, if: :new_record?

  private

  def set_default_status
    self.status ||= false
  end
end
