require 'rails_helper'

feature 'Create point' do

  scenario 'Visitor creates point', js: true do
    visit root_path
    fill_in 'latitude', with: 35.5
    fill_in 'longitude', with: 25.5
    click_on 'Create'
    sleep 1

    expect(page).to have_content Point.last.id
    expect(page).to have_content Point.last.latitude
    expect(page).to have_content Point.last.longitude
    expect(page).to have_selector '#create_form', text: ''
    expect(current_path).to eq root_path
  end
end
