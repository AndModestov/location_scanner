require 'rails_helper'

feature 'Show point' do
  given!(:point){ create(:point) }

  scenario 'Visitor watches point' do
    visit points_path
    click_on point.id

    expect(current_path).to eq point_path(point.id)
    expect(page).to have_content point.id
    expect(page).to have_content point.latitude
    expect(page).to have_content point.longitude
    expect(page).to have_link 'Delete point', href: point_path(point)
  end
end
