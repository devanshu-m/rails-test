class CreateAuthorsBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :authors_books, id: false do |t|
    	t.references :book, index: true
    	t.references :author, index: true
    end
  end
end
