class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators, dependent: :destroy

  validates :title, length: { minimum: 3 }, presence: true
  validates :body, length: { minimum: 15 }, presence: true
  validates_inclusion_of :private, in: [true, false]

end
