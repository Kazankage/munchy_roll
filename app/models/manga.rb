class Manga < ApplicationRecord
  belongs_to :genre
  belongs_to :user


  has_many :reviews
  has_many :users, through: :reviews

  has_one_attached :picture

  accepts_nested_attributes_for :genre


  validates :series, presence: true
  validates :description, presence: true
  validates :genre, presence: true
  validates :publishers, presence: true
  validate :no_repeats

  scope :popularity, -> {left_joins(:reviews).group(:id).order('avg(rating)')}


  def self.alphabetical_order
    order(:series)
  end

  def no_repeats
    manga = Manga.find_by(user_id: user_id, series: series)
    if !!manga && manga != self
      errors.add(:manga, 'has already been added! Baka!')
    end
  end

  def genre_attributes=(attributes)
    self.genre = Genre.find_or_create_by(attributes) if !attributes['name'].empty?
    self.genre
  end

end