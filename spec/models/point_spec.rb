require 'rails_helper'

RSpec.describe Point, type: :model do
  it { should validate_presence_of :latitude }
  it { should validate_presence_of :longitude }
  it { should validate_inclusion_of(:latitude).in_range(-90..90) }
  it { should validate_inclusion_of(:longitude).in_range(-180..180) }

  describe 'to_radians method' do
    let!(:point){ create(:point) }

    it 'converts degrees to radians' do
      expect(point.to_radians 45).to eq 0.785398
    end
  end

  describe 'calculate_range method' do
    let!(:point1){ create(:point, latitude: 55.75, longitude: 37.616) }
    let!(:point2){ create(:point, latitude: 59.8833, longitude: 30.25) }

    it 'converts degrees to radians' do
      expect(point1.calculate_range point2.id).to eq 632.9762529835119
    end
  end
end
