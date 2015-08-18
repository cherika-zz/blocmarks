class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :topics
  has_many :bookmarks
  has_many :likes, dependent: :destroy
  # goes through the relationship on line 9, joint table
  has_many :liked_bookmarks, through: :likes, source: :bookmark

  def liked(bookmark)
    likes.where(bookmark: bookmark).first
  end
end
