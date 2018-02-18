class Wiki < ActiveRecord::Base
  belongs_to :user
  # has_many :

  validates :title, length: { minimum: 3 }, presence: true
  validates :body, length: { minimum: 15 }, presence: true
  # validates :user, presence: true
end
