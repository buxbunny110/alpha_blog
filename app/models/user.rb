class User < ApplicationRecord
  has_many :articles
  validates :username, presence: true, 
                       uniqueness: true, 
                       length: { minimum: 3, maximum: 25 }
  
  validates :email, presence: true, 
                    uniqueness: true, 
                    length: { maximum: 105 },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
end