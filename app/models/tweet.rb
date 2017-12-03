class Tweet < ApplicationRecord

	before_validation :link_check

	belongs_to :user
	has_many :tweet_tags
	has_many :tags, through: :tweet_tags


	validates :message, presence: true, length: {maximum: 140, too_long: "A tweet can only be 140 characters max!"}

	after_validation :apply_link, on: :create

	private

	def apply_link
		arr = self.message.split
		index = arr.map{ |x| x.include?("http://") || x.include?("https://") }.index(true)

		if index 
			url = arr[index]
			arr[index] = "<a href='#{self.link}'target=' '>#{url}</a>"
		end
			self.message = arr.join(" ")
	end

	def link_check

		if self.message.include? "http://"
			check = true
		elsif self.message.include? "https://"
			check = true
		else
			check = false
		end

		if check == true
			arr = self.message.split
			index = arr.map{ |x| x.include? "http"}.index(true)
			self.link = arr[index]

			self.message = arr.join(" ")
		end
	end
	
end
