class Stream < ApplicationRecord
  belongs_to :station

  default_scope { where(status: 1) }
end
