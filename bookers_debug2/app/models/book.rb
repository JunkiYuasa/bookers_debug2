class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  has_many :view_counts, dependent: :destroy
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  scope :old, -> { order(created_at: :asc)}
  scope :latest, -> { order(created_at: :desc)}
  scope :most_favorited, -> { left_outer_joins(:favorites)
  .group(:id).order('COUNT(favorites.id) DESC') }
  scope :most_favorited_recent, -> { joins(:favorites)
  .where("favorites.created_at >= ?", 24.hours.ago).group(:id).order('COUNT(favorites.id) DESC')}
  
  
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
