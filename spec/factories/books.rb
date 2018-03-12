FactoryGirl.define do
	factory :book do
		sequence(:title) { |n| "Book number #{n}"}
	end
end