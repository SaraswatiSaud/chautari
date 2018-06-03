require 'rails_helper'

RSpec.describe Station, type: :model do
  it { should have_and_belong_to_many(:categories) }
  it { should have_many(:streams).dependent(:destroy) }
  it { should belong_to(:language) }
  it { should belong_to(:country) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:country_id) }
  it { should validate_presence_of(:language_id) }

  it { should accept_nested_attributes_for(:streams) }
  it { should delegate_method(:name).to(:country).with_prefix(true) }
end
