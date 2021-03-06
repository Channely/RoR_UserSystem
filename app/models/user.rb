class User < ActiveRecord::Base

  before_save { self.email = email.downcase }
  before_create :create_remember_token

  validates_confirmation_of :password

  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: {minimum:6}
  validates :password_confirmation, presence: true

  validates :question, presence: true
  validates :answer, presence: true



  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrpyt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end



  private

  def create_remember_token
    self.remember_token = User.new_remember_token
  end

end
