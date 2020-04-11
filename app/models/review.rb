class Review < ApplicationRecord
  belongs_to :user
  belongs_to :manga
  
  validates :manga, uniqueness: {scope: :user, message: "Baka! You've done this one already"}
  validates :rating, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than: 6}
  validates :title, presence: true
  validates :summary, presence: true 
  
  scope :popularity, -> {left_joins(:manga).group(:id).order('avg(rating)')}

end