require 'rails_helper'

RSpec.describe Book, type: :model do
	describe "validations" do
		it { should validate_presence_of(:title) }
		it { should validate_uniqueness_of(:title).scoped_to(:author_id).with_message("you can't have two books with the same title")}
		it { should validate_presence_of(:author_ids) }
		it { should have_and_belong_to_many(:authors) }
	end

	it "fetches books for specified author" do
		author1 = FactoryBot.create(:author)
		author2 = FactoryBot.create(:author)
		book1 = FactoryBot.create(:book, author_ids: [author1.id])
		book2 = FactoryBot.create(:book, author_ids: [author2.id])
		book3 = FactoryBot.create(:book, author_ids: [author1.id])

		expect(Book.by_name(author1.id)).to eq([book1, book3])
	end

	it "creates citation for book" do
		author = FactoryBot.create(:author)
		book1 = FactoryBot.create(:print_book, title: 'Some title', author_ids: [author.id])

		expect(book1.print_citation).to eq("Doe John. <em>Some title</em>. 
			New York: Big publisher, 
			1993. Print.")
	end

	it "creates citation for online book" do
		author = FactoryBot.create(:author)
		book2 = FactoryBot.create(:online_book, title: 'Title two', author_ids: [author.id])
	
		expect(book2.online_citation).to eq("Doe John. <em>Title two</em>.
			New York: Big publisher,
			1993. <em>BigBooks.com.</em>
			Web. 14 Mar. 2018.")
	end

	it "creates citation for database book" do
		author = FactoryBot.create(:author)
		book3 = FactoryBot.create(:database_book, title: 'Title three', author_ids: [author.id])
		
		expect(book3.database_citation).to eq("Doe John. <em>Title three</em>.
			New York: Big publisher,
			1993. <em>BigBooks Database.</em>
			Web. 14 Mar. 2018.")
	end
end
