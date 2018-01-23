class User < ActiveRecord::Base
  has_many :projects
  before_save { self.email = email.downcase }
  validates :name, presence: true
  validates :user_type, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
