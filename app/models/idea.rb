class Idea < ActiveRecord::Base

  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  has_many :users, through: :likes

  validates :title, presence: {message: "Must be provided."},
                    uniqueness: true

  validates :body, uniqueness: {scope: :title}

  before_validation :capitalize

  def self.search(term)
    where(["body ILIKE ? OR title ILIKE ?", "%#{term}%", "%#{term}%"])
  end

  def liked_by?(user)
    likes.where(user: user).present?
  end

  def like_for(user)
    likes.find_by_user_id(user)
  end


private

  def capitalize
    self.title.capitalize!
  end

end
