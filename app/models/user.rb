class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :wikis, dependent: :destroy

  before_save { self.role ||= :standard }

  enum role: [:standard, :admin, :premium]

  # def standard?
  #   role == 'standard'
  # end

  # def admin?
  #   role == 'admin'
  # end

  # def premium?
  #   role == 'premium'
  # end

end
