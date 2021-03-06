require 'rails_helper'

RSpec.feature "Dashboards", type: :feature do

  scenario 'check form content' do
    visit(dashboards_new_path)
    expect(page).to have_content('Create your commands with txt file and upload. Follow the exploration on the graph')
    expect(page).to have_selector("form")
    expect(page).to have_selector("img")
    expect(page).to have_content('Explore Mars')
    expect(page).to have_selector("input[type=file][id=import_file]")
    expect(page).to have_selector("input[type=submit]")
  end

  scenario 'check form behavior' do
    visit(dashboards_new_path)
    attach_file('import_file', "#{Rails.root}/spec/files/commands.txt")
    click_on('Save')
    expect(page).to have_current_path(dashboards_new_path)
    expect(page).to have_content('Commands created successfully.')
  end
end
