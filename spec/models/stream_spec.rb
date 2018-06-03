require 'rails_helper'

RSpec.describe Stream, type: :model do
  it { should belong_to(:station) }
end
