class Project < ActiveRecord::Base

    belongs_to :user

    validates :project_name, presence: true, uniqueness: true
    validates :user_id, presence: true
    validates :description, presence: true

  end
  