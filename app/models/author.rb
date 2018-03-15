class Author < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :assign_name

  has_many :books

  def full_name
  	self.first_name && self.last_name ? "#{self.first_name} #{self.last_name}" : "#{self.email}"
  end

  def assign_name
  	self.name = "#{self.first_name} #{self.last_name}"
  end
end
