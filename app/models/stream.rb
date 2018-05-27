class Stream < ApplicationRecord
  belongs_to :station
  before_validation :strip_whitespace

  default_scope { where(status: 1) }

  private
  def strip_whitespace
    self.url.try(:strip!)
  end
end
