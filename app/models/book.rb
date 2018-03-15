class Book < ApplicationRecord

	has_and_belongs_to_many :authors

	validates_presence_of :title, :author_ids

	validates_uniqueness_of :title, {
		scope: :author_id,
		message: "you can't have two books with the same title"
	}

	def self.by_name(author_id)
		joins("join authors_books a on a.book_id = books.id").where("a.author_id = ?", author_id)
	end

	def print_citation
		if self.type_of_book == 'Print'
			"#{authors.map{|a| a.name.split(' ').reverse.join(' ')}.join(', ')}. <em>#{title}</em>. 
			#{ city.present? ? "#{city}:" : ""} #{ publisher.present? ? "#{publisher}," : "" } 
			#{ year_published.present? ? "#{year_published.year}." : ""} Print."
		end
	end

	def online_citation
		if self.type_of_book == 'Online book'
			"#{authors.map{|a| a.name.split(' ').reverse.join(' ')}.join(', ')}. <em>#{title}</em>.
			#{ city.present? ? "#{city}:" : ""} #{ publisher.present? ? "#{publisher}," : "" }
			#{ year_published.present? ? "#{year_published.year}." : ""} #{ website_title.present? ? "<em>#{website_title}.</em>" : ""}
			Web. #{ accessed_date.present? ? "#{accessed_date.day} #{Date::MONTHNAMES[accessed_date.month].slice(0,3)}. #{accessed_date.year}." : ""}"
		end
	end

	def database_citation
		if self.type_of_book == 'Database book'
			"#{authors.map{|a| a.name.split(' ').reverse.join(' ')}.join(', ')}. <em>#{title}</em>.
			#{ city.present? ? "#{city}:" : ""} #{ publisher.present? ? "#{publisher}," : "" }
			#{ year_published.present? ? "#{year_published.year}." : ""} #{ database_name.present? ? "<em>#{database_name}.</em>" : ""}
			Web. #{ accessed_date.present? ? "#{accessed_date.day} #{Date::MONTHNAMES[accessed_date.month].slice(0,3)}. #{accessed_date.year}." : ""}"
		end
	end
end
