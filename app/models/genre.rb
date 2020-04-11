class Genre < ApplicationRecord
    has_many :mangas

    validates :name, presence: true, uniqueness: true
end