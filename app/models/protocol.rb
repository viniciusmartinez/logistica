class Protocol < ActiveRecord::Base
  has_many :suit
  validates_presence_of :numero, :data
end
