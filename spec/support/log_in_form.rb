class LogInForm
	include Capybara::DSL

	def visit_page
		visit('/authors/sign_in')

		self
	end

	def log_in_as(author)
		fill_in("Email", with: author.email)
		fill_in("Password", with: author.password)
		click_on("Log in")

		self
	end
end
