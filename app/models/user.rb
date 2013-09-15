# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  phone                  :string(255)
#  address                :string(255)
#  name                   :string(255)
#  provider               :string(255)
#  uid                    :string(255)
#  authentication_token   :string(255)
#

class User < ActiveRecord::Base
  has_many :members, dependent: :destroy
  has_many :organizations, through: :members
  has_many :events, through: :members
  has_many :teams, through: :members
  # Include default devise modules. Others available are:
  #  :confirmable,
  # :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  validates :email, uniqueness: {case_sensitive: false}
  validates :name, presence: true, length: {in: 2..40}
  validates_format_of :phone,
    :unless => Proc.new { |user| user.phone.blank? },
    :with => /\A\d{3}-\d{3}-\d{4}\z/,
    :message => "- Phone numbers must be in xxx-xxx-xxxx format."

  before_save :ensure_authentication_token


  # tries to find user with those oauth creds, otherwise it creates a new one (with random password)
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(
        name:auth.extra.raw_info.name,
        provider:auth.provider,
        uid:auth.uid,
        email:auth.info.email,
        password:Devise.friendly_token[0,20]
      )
    end
    user
  end

  # Copies data from session if available for OAuth
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end


  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def ensure_authentication_token!
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
      self.save
    end
  end


  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
