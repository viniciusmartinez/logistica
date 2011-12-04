class Contact < ActiveRecord::Base
  scope :main, order("rank DESC").limit(7)
  scope :favorites, where(:favorite => true)
  
  def self.search_by(attribute, query = "")
    if attribute.present?
      if query.present?
        q = "%#{query.downcase}%"
        where(["lower(#{attribute}) LIKE ?", q]).order("#{attribute} ASC")
      else
        order("#{attribute} ASC").limit(10)
      end
    end
  end

  def self.search_everything(query)
    if query.present?
      q = "%#{query.downcase}%"
      where(['lower(name_normalized) LIKE ? OR lower(name) LIKE ? OR lower(email) LIKE ? OR lower(occupation) LIKE ? OR lower(city) LIKE ?', q, q, q, q, q]).order("created_at DESC")
    else
      order("created_at DESC").limit(5)
    end
  end
  
  validates_presence_of :name
  
  has_many :tasks, :dependent => :destroy
  has_many :notes, :dependent => :destroy
  belongs_to :user
  
  mount_uploader :avatar, AvatarUploader
  
  attr_accessible :avatar, :avatar_cache, :email, :name, :name_normalized, :address, :address_number, :address_extra, :neighborhood, :password, :password_confirmation, :zip_code, :city, :state, :phone, :mobile, :occupation, :birthday, :description, :remote_avatar_url, :remove_avatar, :birthday_date, :user, :favorite
  
  def initial
    return '?' if name.blank?
    name.slice(0).chr.upcase
  end
  
  # Override save name so that a normalized version is also saved
  def name=(name)
    self.name_normalized = ActiveSupport::Inflector.transliterate(name)
    super
  end
  
  def get_avatar
    update_attribute :remote_avatar_url, Faces::Public::avatar_url("habibasseiss@gmail.com", "Gravatar")
  end
  
  def validate
    errors.add(:birthday_date, I18n.t("activerecord.errors.messages.invalid")) if @birthday_invalid
  end
  
  def age
    age = Date.today.year - birthday.year
    age -= 1 if Date.today < birthday + age.years
    age
  end
  
  def birthday_date
    I18n.l self.birthday, :format => :default if self.birthday.present?
  end
  
  def birthday_date=(date)
    if date.present?
      @date = DateTime.strptime("#{date}", "#{I18n.t("datetime.formats.date")}")
      self.birthday = Time.parse("#{@date.year}-#{@date.month}-#{@date.day}")
    end
    rescue ArgumentError
      @birthday_invalid = true
  end
  
  def first_name
    name.split(" ")[0].capitalize
  end
  
  def has_birthday_today?
    if birthday.present?
      mmdd = birthday.strftime('%m%d')
      today = Date.today.strftime('%m%d')
      mmdd == today
    end
  end
  
  def has_birthday_tomorrow?
    if birthday.present?
      mmdd = birthday.strftime('%m%d')
      today = Date.tomorrow.strftime('%m%d')
      mmdd == today
    end
  end
  
  # contacts = Contact.find(:all, :select => 'id, date_of_birth').sort_by(&:next_birthday).first(5)
  def next_birthday
    if !has_birthday_today? and !has_birthday_tomorrow?
      year = Date.today.year
      mmdd = birthday.strftime('%m%d')
      year += 1 if mmdd < Date.today.strftime('%m%d')
      mmdd = '0301' if mmdd == '0229' && !Date.parse("#{year}0101").leap?
      return Date.parse("#{year}#{mmdd}")
    end
  end
end
