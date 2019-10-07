require 'rails_helper'

RSpec.describe Item, type: :model do
  # Validation tests
  # Make sure name, amount, and section are present before saving
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:amount) }
  it { should validate_presence_of(:section) }
end
