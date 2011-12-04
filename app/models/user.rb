class User < ActiveRecord::Base
  acts_as_authentic
  
  validates_presence_of :name, :email, :login
  
  has_one :preference, :dependent => :destroy
  
  has_many :contacts, :dependent => :destroy
  has_many :tasks, :dependent => :destroy
  has_many :categories, :dependent => :destroy
  has_many :notes, :dependent => :destroy
  
  attr_accessible :avatar, :avatar_cache, :login, :email, :name, :address, :address_number, :address_extra, :neighborhood, :password, :password_confirmation, :zip_code, :city, :state, :phone, :mobile
  
  mount_uploader :avatar, AvatarUploader
  
  def self.find_by_login_or_email(login)
    User.find_by_login(login) || User.find_by_email(login)
  end
  
  def is_admin?
    self.admin
  end
  
  def self.search(query)
    if query.present?
      q = "%#{query.downcase}%"
      find(:all, :conditions => ['lower(name) LIKE ? OR lower(email) LIKE ?', q, q])
    else
      find(:all)
    end
  end
end
