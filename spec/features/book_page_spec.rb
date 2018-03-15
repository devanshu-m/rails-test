require 'rails_helper'

feature 'book page' do
	scenario 'book show page' do
		book = FactoryBot.create(:book, title: 'First book title', author_ids: [FactoryBot.create(:author).id])

		visit("/books/#{book.id}")

		expect(page).to have_content('First book title')
	end
end
