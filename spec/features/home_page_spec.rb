require 'rails_helper'

feature 'homepage' do
	scenario 'welcome' do
		visit('/')
		expect(page).to have_content('Welcome')
	end

	scenario 'books page' do
		visit('/')
		click_on('All Books')
		visit('/books')
		expect(page).to have_content('Books')
	end
end