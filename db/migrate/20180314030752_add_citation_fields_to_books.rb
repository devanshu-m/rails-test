class AddCitationFieldsToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :city, :string
    add_column :books, :publisher, :string
    add_column :books, :year_published, :date
    add_column :books, :type_of_book, :string
    add_column :books, :website_title, :string
    add_column :books, :database_name, :string
    add_column :books, :accessed_date, :date
  end
end
