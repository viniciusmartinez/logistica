class Task < ActiveRecord::Base
  acts_as_commentable
  
  scope :overdue, where("due_at < ? AND completed = ?", Date.today, false).order("due_at ASC")
  scope :not_overdue, where("due_at >= ? AND completed = ?", Date.today, false).order("due_at ASC")
  scope :incomplete, where(:completed => false)
  scope :complete, where(:completed => true)
  scope :last_tasks, where("completed = ?", false).order("due_at ASC")
  
  scope :due_to_today, where( :due_at => (Time.zone.now.at_midnight)..(Time.zone.now.end_of_day) ).order("created_at DESC")
  
  scope :due_to_tomorrow, where( :due_at => (Time.zone.now.at_midnight+1.day)..(Time.zone.now.end_of_day+1.day) ).order("created_at DESC")
  
  scope :due_to_this_week, where( :due_at => (Time.zone.now.at_midnight+1.day)..(Time.zone.now.at_midnight.end_of_week) ).order("due_at ASC")
  
  scope :due_to_next_week, where( :due_at => (Time.zone.now.end_of_week.at_midnight+1.day)..(Time.zone.now.end_of_week.end_of_day+1.week) ).order("due_at ASC")
  
  scope :due_to_later, where("date(due_at) > ?", Date.today.end_of_week+1.week).order("due_at ASC")
  
  def self.search_everything(query)
    if query.present?
      q = "%#{query.downcase}%"
      where({:completed => false}).where(['lower(name) LIKE ?', q]).order("created_at DESC")
    else
      where({:completed => false}).order("created_at DESC").limit(5)
    end
  end
  
  belongs_to :user
  belongs_to :contact
  
  has_many :categorization
  has_many :categories, :through => :categorization
  
  validates_presence_of :name
  # validates_presence_of :start_at_time, :due_at_date, :due_at_time, :if => Proc.new{|s| !s.all_day and s.start_at_date.present? }
  
  def overdue?
    due_at < Date.today and completed == false
  end
  
  def due_to_today?
    due_at == Date.today
  end
  
  def due_to_until_today?
    due_at <= Date.today
  end
  
  # date virtual attribute to start_at as a string
  
  def start_at_date
    I18n.l self.start_at, :format => :default if self.start_at.present?
  end
  
  def start_at_date=(date)
    #self.update_attribute(:start_at, DateTime.strptime("#{date} #{self.start_at_time_utc}", "#{I18n.t("datetime.formats.default")}"))
    if date.present?
      @date = DateTime.strptime("#{date}", "#{I18n.t("datetime.formats.date")}")
    else
      @date = Time.zone.now
    end
    if self.start_at.present?
      @time = self.start_at
    else
      @time = Time.zone.now.midnight
    end
    self.start_at = Time.zone.parse("#{@date.year}-#{@date.month}-#{@date.day} #{@time.hour}:#{@time.min}") if date.present?
  end
  
  # time virtual attribute to due_at as a string
  
  def due_at_date
    I18n.l self.due_at, :format => :datepicker if self.due_at.present?
  end
  
  def due_at_date=(date)
    if date.present?
      @date = DateTime.strptime("#{date}", "%Y-%m-%d")
    else
      @date = Time.zone.now
    end
    if self.due_at.present?
      @time = self.due_at
    else
      @time = Time.zone.now.midnight
    end
    self.due_at = Time.zone.parse("#{@date.year}-#{@date.month}-#{@date.day} #{@time.hour}:#{@time.min}") if date.present?
  end
  
  def due_at_time
    if self.due_at.present?
      I18n.l self.due_at, :format => :time
    else
      "00:00"
    end
  end
  
  def due_at_time_utc
    I18n.l self.due_at.utc, :format => :time
  end
  
  def due_at_time=(time)
    if time.present?
      @time = Time.zone.parse(time)
    else
      @time = Time.zone.now
    end
    if self.due_at.present?
      @date = self.due_at
    else
      @date = Time.zone.now
    end
    self.due_at = Time.zone.parse("#{@date.year}-#{@date.month}-#{@date.day} #{@time.hour}:#{@time.min}") if time.present?
    rescue ArgumentError
      @due_at_time_invalid = true
  end
  
  def validate
    errors.add(:due_at_time, I18n.t("activerecord.errors.messages.invalid")) if @due_at_time_invalid
  end
end
