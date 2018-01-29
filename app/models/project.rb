class Project < ActiveRecord::Base

    has_many :user_projects, :dependent => :destroy
    has_many :users, through: :user_projects

    has_many :tasks, :dependent => :destroy

    validates :project_name, presence: true, uniqueness: true
    validates :description, presence: true
    validates :creator_id, presence: true

  end
  


