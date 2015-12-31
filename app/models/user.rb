class User < ActiveRecord::Base
  before_create :generate_remember_token
  before_save { email.downcase! }
  before_save { name.capitalize! }

  has_many :created_events,  class_name: Event,
                             foreign_key: :creator_id,
                             dependent:   :destroy

  has_many :attended_events, through: :invitations,
                             source:  :event

  has_many :invitations,     foreign_key: :attendee_id,
                             dependent:   :destroy

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates_presence_of :name, :email, :password
  validates :name,  length:     { maximum: 30 }
  validates :email, length:     { maximum: 255 },
                    format:     { with: EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { in: 6..20 }, allow_nil: true
  has_secure_password

  def self.create_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def generate_remember_token
      self.remember_token = User.digest(User.create_token)
    end
end
