require 'rails_helper'

feature 'Delete point' do
  given!(:point){ create(:point) }
  before { visit root_path }

  scenario 'Visitor deletes point', js: true do
    within "#point_#{point.id}" do
      expect(page).to have_content point.id
      expect(page).to have_content point.latitude
      expect(page).to have_content point.longitude

      click_on 'Delete point'
      sleep 1

      expect(page).to_not have_content point.id
      expect(page).to_not have_content point.latitude
      expect(page).to_not have_content point.longitude
      expect(current_path).to eq root_path
    end
  end
end
