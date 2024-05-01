class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def self.search_for(word, search)
    if search == "perfect"
      Book.where(title: word)
    elsif search == "forward"
      Book.where("title LIKE?", "#{word}%")
    elsif search == "backward"
      Book.where("title LIKE?", "%#{word}")
    elsif search == "partial"
      Book.where("title LIKE?", "%#{word}%")
    else
      Book.all
    end
  end
  
end
