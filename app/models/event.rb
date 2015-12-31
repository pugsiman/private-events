class Event < ActiveRecord::Base
  before_save :format_time

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
  scope :upcoming, -> { where('date > ?', Date.today) }
  scope :past,     -> { where('date < ?', Date.today) }

  def format_time
    self.time = time.to_datetime.change(day: date.day,
                                        month: date.month,
                                        year: date.year).to_time
  end

  def valid_date
    return unless date && date < Date.today
    errors.add(:event, "can't be created in the past")
  end

  def valid_time
    return unless date == Date.today && time && time.hour < Time.now.hour
    errors.add(:event, "can't be created in the past")
  end
end
