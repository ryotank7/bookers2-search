class Book < ApplicationRecord
	belongs_to :user
	validates :title, presence: true
	validates :body, presence: true,length:{maximum: 200}
	has_many :book_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end
	def self.search(search)
		if search
			Book.where(['title LIKE ?', "%#{search}%"])
			Book.where(['book.user.name LIKE ?', "%#{search}%"])
		else
			Book.all
		end
	end
end