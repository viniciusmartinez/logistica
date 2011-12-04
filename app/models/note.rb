class Note < ActiveRecord::Base
  acts_as_commentable
  belongs_to :user
  belongs_to :contact
  
  scope :last_notes, order("date DESC").limit(10)
  scope :by_date, order("date DESC")
  
  def self.search_everything(query)
    if query.present?
      q = "%#{query.downcase}%"
      where(['lower(name) LIKE ?', q]).order("date DESC")
    else
      order("date DESC").limit(5)
    end
  end
  
  validates_presence_of :date, :name
  
  def date_string
    date.to_s
  end
  
  def date_string=(date)
    self.date = Time.zone.parse(date)
  end
end
