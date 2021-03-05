require 'rails_helper'

RSpec.feature "Dashboards", type: :feature do

  scenario 'Check Form Content' do
    visit(dashboards_new_path)
    expect(page).to have_content('Crie seus comandos com arquivo txt e faça upload')
    expect(page).to have_selector("form")
    expect(page).to have_selector("img")
    expect(page).to have_content('Explore Marte')
    expect(page).to have_content('Crie seus comandos com arquivo txt')
    expect(page).to have_selector("input[type=file][id=import_file]")
    expect(page).to have_selector("input[type=submit]")
  end

  scenario 'Check Form Behavior' do
    visit(dashboards_new_path)
    attach_file('import_file', "#{Rails.root}/spec/files/commands.txt")
    click_on('Save')
    expect(page).to have_current_path(dashboards_new_path)
    expect(page).to have_content('Comandos criados com sucesso.')
  end
end