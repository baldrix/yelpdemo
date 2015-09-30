class Restaurant < ActiveRecord::Base
	mount_uploader :image, ImageUploader
	has_many :reviews

	validates :name , :address,:phone , :website,:image,presence: true
	validates :phone, format:{with: /\A\(\d{3}\) \d{3}-\d{4}\z/,
					message: "must be in the format (123) 123-4567"}
	validates :website ,format: {with: /\Ahttps?:\/\/.*\z/,
					message:"must start with http://"}
end
