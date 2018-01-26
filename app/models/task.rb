class Task < ActiveRecord::Base

     
    belongs_to :creator, :class_name => 'User'
    belongs_to :resolver, :class_name => 'User'

    belongs_to :projects

    validates :title, presence: true, uniqueness: true
    validates :description, presence: true
    validates :type , presence: true
    validates :status, presence: true

  end