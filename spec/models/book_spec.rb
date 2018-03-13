require 'rails_helper'

RSpec.describe Book, type: :model do
	describe "validations" do
		it { should validate_presence_of(:title) }
		it { should validate_uniqueness_of(:title).scoped_to(:author_id).with_message("you can't have two books with the same title")}
		it { should validate_presence_of(:author) }
		it { should belong_to(:author) }
	end

	it "fetches books for specified author" do
		author1 = FactoryGirl.create(:author)
		author2 = FactoryGirl.create(:author)
		book1 = FactoryGirl.create(:book, author: author1)
		book2 = FactoryGirl.create(:book, author: author2)
		book3 = FactoryGirl.create(:book, author: author1)

		expect(Book.by_name(author1.id)).to eq([book1, book3])
	end
end
