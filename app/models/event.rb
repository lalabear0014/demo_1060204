class Event < ApplicationRecord
	
	validates_presence_of :name

	has_many :attendees
	belongs_to :category

	delegate :name, :to => :category, :prefix => true, :allow_nil => true
	
	has_many :event_groupships
	has_many :groups, :through => :event_groupships

end
