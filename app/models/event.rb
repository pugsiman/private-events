class Event < ActiveRecord::Base
  # before_create :format_time

  belongs_to :creator,   class_name:  'User'
  has_many :invitations, foreign_key: :event_id,
                         dependent:   :destroy
  has_many :attendees,   through:     :invitations,
                         source:      :attendee,
                         dependent:   :destroy

  validates_presence_of :title, :description, :location, :date, :time
  validates :description, length: { in: 6..300 }
  validates :location,    length: { maximum: 30 }
  validates :title,       length: { in: 4..30 }

  validate :valid_date
  validate :valid_time

  default_scope       { order(date: :asc) }
  scope :upcoming, -> { where('date > ?', Date.today) }
  scope :past,     -> { where('date < ?', Date.today) }

  def format_time
    date_today = Date.today
    self.time = time.to_datetime.change(day: date_today.day,
                                        month: date_today.month,
                                        year: date_today.year).to_time
  end

  def valid_date
    if date < Date.today
      errors.add(:date, "Event can't be created in the past")
    else
      date.present?
    end
  end

  def valid_time
    return unless date == Date.today && date.present? && time.present?
    return unless time.hour < Time.now.hour
    errors.add(:time, "Event can't be created in the past")
  end
end
