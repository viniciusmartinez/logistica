class Category < ActiveRecord::Base
  belongs_to :user
  
  has_many :categorization
  has_many :tasks, :through => :categorization
  
  validates_presence_of :name
end
