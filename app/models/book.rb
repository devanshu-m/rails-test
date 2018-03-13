class Book < ApplicationRecord

	belongs_to :author

	validates_presence_of :title, :author

	validates_uniqueness_of :title, {
		scope: :author_id,
		message: "you can't have two books with the same title"
	}

	def self.by_name(author_id)
		where("author_id = ?", author_id)
	end
end
