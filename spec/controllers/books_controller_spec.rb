require 'rails_helper'

describe BooksController, type: :controller do
	describe "GET index" do
		it "renders :index template" do
			get :index
			expect(response).to render_template(:index)
		end
	end

	describe "GET show" do
		let(:book) { FactoryGirl.create(:book) }

		it "renders :show template" do
			get :show, params: { id: book }
			expect(response).to render_template(:show)
		end

		it "assigns requested Book to @book" do
			get :show, params: { id: book }
			expect(assigns(:book)).to eq(book)
		end
	end

	describe "GET new" do
		it "renders :new template" do
			get :new
			expect(response).to render_template(:new)
		end

		it "assigns new Book to @book" do
			get :new
			expect(assigns(:book)).to be_a_new(Book)
		end
	end

	describe "GET edit" do
		let(:book) { FactoryGirl.create(:book) }

		it "renders :edit template" do
			get :edit, params: { id: book }
			expect(response).to render_template(:edit)
		end

		it "assigns requested book to edit template" do
			get :edit, params: { id: book }
			expect(assigns(:book)).to eq(book)
		end
	end

	describe "POST create" do
		context "valid data" do
			let(:valid_data) { FactoryGirl.attributes_for(:book) }

			it "redirects to books#show" do
				post :create, params: { book: valid_data }
				expect(response).to redirect_to(book_path(assigns[:book]))
			end

			it "creates new book and adds it to database" do
				expect {
					post :create, params: { book: valid_data }
				}.to change(Book, :count).by(1)
			end
		end

		context "invalid data" do
			let(:invalid_data) { FactoryGirl.attributes_for(:book, title: '') }

			it "renders :new template" do
				post :create, params: { book: invalid_data }
				expect(response).to render_template(:new)
			end

			it "does not create new book in the database" do
				expect {
					post :create, params: { book: invalid_data }
					}.not_to change(Book, :count)
			end
		end
	end

	describe "PUT update" do
		let(:book) { FactoryGirl.create(:book) }

		context "valid data" do
			let(:valid_data) { FactoryGirl.attributes_for(:book, title: "Updated title") }

			it "redirects to books#show" do
				put :update, params: { id: book, book: valid_data }
				expect(response).to redirect_to(book_path(assigns[:book]))
			end

			it "updates assigned book in database" do
				put :update, params: { id: book, book: valid_data }
				book.reload
				expect(book.title).to eq("Updated title")
			end
		end

		context "invalid data" do
			let(:invalid_data) { FactoryGirl.attributes_for(:book, title: "", author: "New author") }

			it "renders :edit template" do
				put :update, params: { id: book, book: invalid_data }
				expect(response).to render_template(:edit)
			end

			it "does not update assigned book in database" do
				put :update, params: { id: book, book: invalid_data }
				book.reload
				expect(book.author).not_to eq("New author")
			end
		end
	end

	describe "DELETE destroy" do
		let(:book) { FactoryGirl.create(:book) }

		it "redirects to books#index" do
			delete :destroy, params: { id: book }
			expect(response).to redirect_to(books_path)
		end

		it "deletes book from database" do
			delete :destroy, params: { id: book }
			expect(Book.exists?(book.id)).to be_falsy
		end
	end
end