FactoryGirl.define do
	factory :book do
		sequence(:title) { |n| "Book number #{n}"}
		city 'New York'
		publisher 'Big publisher'
		year_published '1993-01-01'

		factory :print_book do
		  	type_of_book 'Print'
		end

		factory :online_book do
			type_of_book 'Online book'
			website_title 'BigBooks.com'
			accessed_date '2018-03-14'
		end

		factory :database_book do
			type_of_book 'Database book'
			database_name 'BigBooks Database'
			accessed_date '2018-03-14'
		end
	end
end