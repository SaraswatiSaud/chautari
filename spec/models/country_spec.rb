require 'rails_helper'

RSpec.describe Country, type: :model do
  it { should have_many(:stations) }
end
