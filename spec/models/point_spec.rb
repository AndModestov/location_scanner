require 'rails_helper'

RSpec.describe Point, type: :model do
  it { should validate_presence_of :latitude }
  it { should validate_presence_of :longitude }
  it { should validate_inclusion_of(:latitude).in_range(-90..90) }
  it { should validate_inclusion_of(:longitude).in_range(-180..180) }
end
