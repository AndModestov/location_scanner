require 'rails_helper'

feature 'Index points' do
  given!(:points){ create_list(:point, 3) }

  scenario 'Visitor watches the points list' do
    visit points_path

    points.each do |point|
      expect(page).to have_link(point.id, href: point_path(point))
      expect(page).to have_content point.latitude
      expect(page).to have_content point.longitude
    end

    expect(page).to have_field 'latitude'
    expect(page).to have_field 'longitude'
    expect(page).to have_xpath("//input[@value='Create']")
  end
end
