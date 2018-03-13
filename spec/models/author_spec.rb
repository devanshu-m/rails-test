require 'rails_helper'

RSpec.describe Author, type: :model do
  describe "instance method validations" do
  	it "concatenates first and last names of authors if present" do
  		author1 = Author.new(first_name: "John", last_name: "Doe")
  		author2 = Author.new(first_name: nil, last_name: nil, email: "john@doe.com")
  		expect(author1.full_name).to eq("John Doe")
  		expect(author2.full_name).to eq("john@doe.com")
  	end
  end
end
