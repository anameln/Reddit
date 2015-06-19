# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)      not null
#  password_digest :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#  session_token   :string(255)      not null
#

class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 3, allow_nil: true }

  after_initialize :ensure_session_token

  has_many(
    :subs,
    class_name: 'Sub',
    foreign_key: :moderator_id,
    primary_key: :id
  )
  
  has_many(
    :posts,
    class_name: 'Post',
    foreign_key: :author_id,
    primary_key: :id
  )

  attr_reader :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    return nil if user.nil? || !user.is_password?(password)
    user
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def self.generate_session_token
    begin
      token = SecureRandom.base64(16)
    end until !User.exists?(session_token: token)

    token
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

end
