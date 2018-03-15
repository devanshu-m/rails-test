require 'rails_helper'

describe BooksController, type: :controller do

	shared_examples "guest view for books" do
		describe "GET index" do
			it "renders :index template" do
				get :index
				expect(response).to render_template(:index)
			end
		end

		describe "GET show" do
			let(:book) { FactoryBot.create(:book, author_ids: [author.id]) }

			it "renders :show template" do
				get :show, params: { id: book }
				expect(response).to render_template(:show)
			end

			it "assigns requested Book to @book" do
				get :show, params: { id: book }
				expect(assigns(:book)).to eq(book)
			end
		end
	end

	describe "guest user" do
		let(:author) { FactoryBot.create(:author) }
		let(:book) { FactoryBot.create(:book, author_ids: [author.id]) }

		it_behaves_like "guest view for books"

		describe "GET new" do
			it "redirects to log in page" do
				get :new
				expect(response).to redirect_to(new_author_session_url)
			end
		end

		describe "POST create" do
			it "redirects to log in page" do
				post :create, params: { book: FactoryBot.attributes_for(:book) }
				expect(response).to redirect_to(new_author_session_url)
			end
		end

		describe "GET edit" do
			it "redirects to log in page" do
				get :edit, params: { id: book }
				expect(response).to redirect_to(new_author_session_url)
			end
		end

		describe "PUT update" do
			it "redirects to log in page" do
				put :update, params: { id: book, book: FactoryBot.attributes_for(:book) }
				expect(response).to redirect_to(new_author_session_url)
			end
		end

		describe "DELETE destroy" do
			it "redirects to log in page" do
				delete :destroy, params: { id: book }
				expect(response).to redirect_to(new_author_session_url)
			end
		end
	end

	describe "authenticated author" do
		let(:author) { FactoryBot.create(:author) }
		before do
			sign_in(author)
		end

		it_behaves_like "guest view for books"

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

		describe "POST create" do
			context "valid data" do
				let(:valid_data) { FactoryBot.attributes_for(:book, author_ids: [author.id]) }

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
				let(:invalid_data) { FactoryBot.attributes_for(:book, title: '') }

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

		context "has not written the book" do
			let(:author1) { FactoryBot.create(:author, first_name: "Jane") }
			describe "GET edit" do
				it "redirects to books page" do
					get :edit, params: { id: FactoryBot.create(:book, author_ids: [author1.id]) }
					expect(response).to redirect_to(books_path)
				end
			end

			describe "PUT update" do
				it "redirects to books page" do
					put :update, params: { id: FactoryBot.create(:book, author_ids: [author1.id]), book: FactoryBot.attributes_for(:book) }
					expect(response).to redirect_to(books_path)
				end
			end

			describe "DELETE destroy" do
				it "redirects to books page" do
					delete :destroy, params: { id: FactoryBot.create(:book, author_ids: [author1.id]) }
					expect(response).to redirect_to(books_path)
				end
			end
		end

		context "has written the book" do
			let(:book) { FactoryBot.create(:book, author_ids: [author.id]) }

			describe "GET edit" do
				it "renders :edit template" do
					get :edit, params: { id: book }
					expect(response).to render_template(:edit)
				end

				it "assigns requested book to edit template" do
					get :edit, params: { id: book }
					expect(assigns(:book)).to eq(book)
				end
			end

			describe "PUT update" do
				context "valid data" do
					let(:valid_data) { FactoryBot.attributes_for(:book, title: "Updated title") }

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
					let(:invalid_data) { FactoryBot.attributes_for(:book, title: "") }

					it "renders :edit template" do
						put :update, params: { id: book, book: invalid_data, city: "New city" }
						expect(response).to render_template(:edit)
					end

					it "does not update assigned book in database" do
						put :update, params: { id: book, book: invalid_data, city: "New city" }
						book.reload
						expect(book.city).not_to eq("New city")
					end
				end
			end

			describe "DELETE destroy" do
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
	end
end
