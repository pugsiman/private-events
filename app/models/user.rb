class User < ActiveRecord::Base
  has_many :created_events, class_name: Event,
                            foreign_key: :creator_id,
                            dependent: :destroy

  before_create :generate_remember_token
  before_save { self.email = email.downcase }

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name,     presence: true, length: { maximum: 35 }
  validates :email,    presence: true, length: { maximum: 255 },
                       format: { with: EMAIL_REGEX },
                       uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { in: 6..20 }, allow_nil: true
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
