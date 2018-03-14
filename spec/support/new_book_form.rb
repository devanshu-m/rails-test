class NewBookForm
	include Capybara::DSL

	def visit_page
		visit('/books')
		click_on('New Book')
		
		self
	end

	def fill_in_with(params = {})
		fill_in('Title', with: params.fetch(:title, 'First book title'))
		fill_in('City', with: 'New York')
		fill_in('Publisher', with: 'Big Publisher')
		select(Date.today.year, from: 'Year Published')
		select('Online book', from: 'Type of book')
		fill_in('Website title', with: 'BigBook.com')
		select(Date.today.year, from: 'Date accessed')

		self
	end

	def submit
		click_on('Create Book')

		self
	end
end