class Book < ApplicationRecord
	belongs_to :user
	belongs_to :category
	has_many :reviews, :dependent => :destroy 
	validates_presence_of :title, :description, :author, :category_id, :book_img

	has_attached_file :book_img, styles: { book_index: "250x350>", book_show: "325x475>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :book_img, content_type: /\Aimage\/.*\Z/
end
