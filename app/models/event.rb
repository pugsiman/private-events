class Event < ActiveRecord::Base
  belongs_to :creator,   class_name:  'User'

  has_many :invitations, foreign_key: :event_id,
                         dependent:   :destroy

  has_many :attendees,   through:     :invitations, source: :attendee,
                         dependent:   :destroy

  validates_presence_of :title, :description, :location, :date # , :time
  validates :description, length: { in: 6..300 }
  validates :location,    length: { maximum: 30 }
  validates :title,       length: { in: 4..30 }

  default_scope       { order('date asc') }
  scope :upcoming, -> { where('date > ?', Date.today) }
  scope :past,     -> { where('date < ?', Date.today) }
end
