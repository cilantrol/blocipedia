class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators

  validates :title, length: { minimum: 3 }, presence: true
  validates :body, length: { minimum: 15 }, presence: true

  # delegate :users, to: :collaborations

  # def collaborations
  #   Collaboration.where(user_id: id)
  # end

  # Delegate on Line10
  # def users
  #   # Refactored in Collaborations
  #   # User.where( id: collaborations.pluck(:user_id) )
  #   collaborations.users
  # end

end
