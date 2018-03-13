require 'rails_helper'

feature 'book page' do
	scenario 'book show page' do
		book = FactoryGirl.create(:book, title: 'First book title', author: FactoryGirl.create(:author))

		visit("/books/#{book.id}")

		expect(page).to have_content('First book title')
	end
end