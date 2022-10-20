class Article < ApplicationRecord
	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :likes, dependent: :destroy
	has_many :dislikes, dependent: :destroy
	include ImageUploader::Attachment(:image)
 # 	validates :title, presence: true
	# validates :user_id, presence: true

	# validate :check_status


  after_rollback :greeting_message

  def greeting_message
    # debugger
    # puts "hello bird "
  end  

end
