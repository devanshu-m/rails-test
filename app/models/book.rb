class Book < ApplicationRecord

	belongs_to :author

	validates_presence_of :title
end
