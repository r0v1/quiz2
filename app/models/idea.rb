class Idea < ActiveRecord::Base

  belongs_to :user

  has_many :comments, dependent: :destroy

  validates :title, presence: {message: "Must be provided."},
                    uniqueness: true

  validates :body, uniqueness: {scope: :title}

  before_validation :capitalize

  def self.search(term)
    where(["body ILIKE ? OR title ILIKE ?", "%#{term}%", "%#{term}%"])
  end

private

  def capitalize
    self.title.capitalize!
  end

end
