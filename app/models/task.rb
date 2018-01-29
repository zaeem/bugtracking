class Task < ActiveRecord::Base

  
     
    belongs_to :creator, :class_name => 'User'
    belongs_to :resolver, :class_name => 'User'
    belongs_to :projects , :dependent => :destroy

    validates :title, presence: true, uniqueness: true
    validates :description, presence: true
    validates :task_category , presence: true
    validates :status, presence: true
    validates :creator_id, presence: true
    validates :resolver_id, presence: true
    validates :project_id, presence: true

    mount_uploader :avatar, AvatarUploader 
  end