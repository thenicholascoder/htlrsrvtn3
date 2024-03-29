class User < ApplicationRecord
  has_many :reservations, dependent: :destroy
  has_many :rooms, through: :reservations
  # getter and setter, it creates an attribute for your current User model even without value yet
  attr_accessor :remember_token, :activation_token
  before_create :create_activation_digest
  before_save   :downcase_email
  normalizes :email, with: ->(email) {email.strip.downcase}
  unless defined?(VALID_EMAIL_REGEX)
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  end
  validates :first_name, presence: true, length: { minimum: 2, maximum: 25 }
  validates :last_name, presence: true, length: { minimum: 2, maximum: 25 }
  validates :country, presence: true, length: { minimum: 4, maximum: 56 }
  validates :mobile, presence: true, length: { minimum: 10, maximum: 15 }
  validates :email, presence: true, length: { minimum: 6, maximum: 254 },
            format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true


  class << self
    # Returns the hash digest of the given string.
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end


    # Returns a random token.
    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
    remember_digest
  end

  # Returns a session token to prevent session hijacking.
  # We reuse the remember digest for convenience.
  def session_token
    remember_digest || remember
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Activates an account.
  # def activate
  #   update_attribute(:activated,    true)
  #   update_attribute(:activated_at, Time.zone.now)
  # end

  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
    # update_columns(activated: true, activated_at: Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  private

  # Converts email to all lowercase.
  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
  # Create the token and digest.
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
