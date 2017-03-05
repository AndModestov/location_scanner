FactoryGirl.define do
  factory :point do
    latitude 10
    longitude 10
  end

  factory :invalid_point, class: 'Point' do
    latitude 95
    longitude 185
  end
end
