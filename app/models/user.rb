class User < ApplicationRecord
  has_many :articles , dependent: :destroy
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :dislikes, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_one :user_profile
  has_many :profile ,dependent: :destroy      

end
