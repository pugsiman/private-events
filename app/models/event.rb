class Event < ActiveRecord::Base
  belongs_to :creator,   class_name:  'User'
  has_many :invitations, foreign_key: :event_id,
                         dependent:   :destroy
  has_many :attendees,   through:     :invitations,
                         source:      :attendee,
                         dependent:   :destroy

  validates_presence_of :title, :description, :location, :date, :time
  validates :description, length: { in: 5..600 }
  validates :location,    length: { maximum: 40 }
  validates :title,       length: { in: 4..50 }

  validate :valid_date
  validate :valid_time

  default_scope       { order(date: :asc) }
  scope :upcoming, -> { where('date >= ?', Time.zone.today) }
  scope :past,     -> { where('date < ?', Time.zone.today) }

  def valid_date
    return unless date && date < Time.zone.today
    errors.add(:event_date, "can't be in the past")
  end

  def valid_time
    return unless date == Time.zone.today &&
                  time && time.hour < Time.zone.now.hour
    errors.add(:event_time, "can't be in the past")
  end
end
