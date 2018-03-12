class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :wikis, dependent: :destroy

  before_save { self.role ||= :standard }
  # after_action :downgrade only: :update

  enum role: [:standard, :admin, :premium]

  # def downgrade

  #   #if user is standard?
  #   #find all wikis made by that user
  #   #set all wikis made by that user to :private false

  #     #if current_user.standard?
  #     #  current_user.wiki.where( :private, true).update_atrribute( :private, false)
  #     #

  #     # current_user.wiki
  # end
end
