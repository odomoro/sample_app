# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password
  has_many :microposts, dependent: :destroy
  
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
 
  validates :password, presence: true, length: {minimum: 6}
  validates :password_confirmation, presence: true
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX},  uniqueness: { case_sensitive: false }
  
  def feed
    # This is preliminary. See "Following users" for the full implementation.
    Micropost.where("user_id = ?", id)
  end
  
  
  private
  
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64      
    end  
end


