class User < ActiveRecord::Base
  has_many :projects
  before_save { self.email = email.downcase }
  validates :name, presence: true
  validates :user_type, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable



        def self.search(param)
          #param.strip!
          #param.downcase!
          to_send_back = (name_matches(param) + email_matches(param)).uniq
          return nil unless to_send_back
          to_send_back
        end
        
        def self.name_matches(param)
          matches('name', param)
        end
        
        def self.email_matches(param)
          matches('email', param)
        end
        
        def self.matches(field_name, param)
          where("#{field_name} like ?", "%#{param}%")
        end
end
