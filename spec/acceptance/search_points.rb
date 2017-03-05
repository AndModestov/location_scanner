require 'rails_helper'

feature 'Search points' do
  given!(:point1){ create(:point, latitude: 25.5, longitude: 35.5) }
  given!(:point2){ create(:point, latitude: 26.5, longitude: 37.5) }
  given!(:point3){ create(:point, latitude: 27.5, longitude: 40.5) }
  given!(:point4){ create(:point, latitude: 28.5, longitude: 45.5) }
  before { visit point_path(point1) }

  scenario 'Visitor searches points in radius', js: true do
    fill_in 'Enter Radius', with: 600
    click_on 'Search'
    sleep 1

    within "#nearest_points_#{point1.id}" do
      expect(page).to have_content point2.latitude
      expect(page).to have_content point2.longitude
      expect(page).to have_content point3.latitude
      expect(page).to have_content point3.longitude
      expect(page).to_not have_content point4.latitude
      expect(page).to_not have_content point4.longitude
    end
  end
end
