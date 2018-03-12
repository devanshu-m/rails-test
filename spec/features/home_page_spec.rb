require 'rails_helper'

feature 'homepage' do
	scenario 'welcome' do
		visit('/')
		expect(page).to have_content('Welcome')
	end
end