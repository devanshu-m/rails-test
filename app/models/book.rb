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

	def print_citation
		if self.type_of_book == 'Print'
			"#{author.last_name}, #{author.first_name}. <em>#{title}</em>. 
			#{ city.present? ? "#{city}:" : ""} #{ publisher.present? ? "#{publisher}," : "" } 
			#{ year_published.present? ? "#{year_published.year}." : ""} Print."
		end
	end

	def online_citation
		if self.type_of_book == 'Online book'
			"#{author.last_name}, #{author.first_name}. <em>#{title}</em>.
			#{ city.present? ? "#{city}:" : ""} #{ publisher.present? ? "#{publisher}," : "" }
			#{ year_published.present? ? "#{year_published.year}." : ""} #{ website_title.present? ? "<em>#{website_title}.</em>" : ""}
			Web. #{ accessed_date.present? ? "#{accessed_date}." : ""}"
		end
	end

	def database_citation
		if self.type_of_book == 'Database book'
			"#{author.last_name}, #{author.first_name}. <em>#{title}</em>.
			#{ city.present? ? "#{city}:" : ""} #{ publisher.present? ? "#{publisher}," : "" }
			#{ year_published.present? ? "#{year_published.year}." : ""} #{ database_name.present? ? "<em>#{database_name}.</em>" : ""}
			Web. #{ accessed_date.present? ? "#{accessed_date}." : ""}"
		end
	end
end
