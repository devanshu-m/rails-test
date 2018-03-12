class NewBookForm
	include Capybara::DSL

	def visit_page
		visit('/books')
		click_on('New Book')
		
		self
	end

	def fill_in_with(params = {})
		fill_in('Title', with: params.fetch(:title, 'First book title'))

		self
	end

	def submit
		click_on('Create Book')

		self
	end
end