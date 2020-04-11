class User < ApplicationRecord
    has_many :reviews
    has_many :reviewed_mangas, through: :reviews, source: :manga
    has_many :mangas

    has_secure_password

    validates :username, uniqueness: true,  presence: true
    validates :email, uniqueness: true,  presence: true

end