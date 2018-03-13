require 'rails_helper'
require_relative '../support/new_book_form'
require_relative '../support/log_in_form'

feature 'create new book' do
	let(:new_book_form) { NewBookForm.new }
	let(:log_in_form) { LogInForm.new }
	let(:author) { FactoryGirl.create(:author) }

	background do
		log_in_form.visit_page.log_in_as(author)
	end

	scenario 'with valid data' do
		new_book_form.visit_page.fill_in_with(
			title: 'First book title',
			author_id: author
		).submit

		expect(page).to have_content('Book was successfully created.')
		expect(Book.last.title).to eq('First book title')
	end

	scenario 'with invalid data' do
		new_book_form.visit_page.submit

		expect(page).to have_content("can't be blank")
	end
end