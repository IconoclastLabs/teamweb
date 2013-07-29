# == Schema Information
#
# Table name: organizations
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  about      :string(255)
#  location   :string(255)
#  contact    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  slug       :string(255)
#

class Organization < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :events, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :users, through: :members
  validates :name, :contact, presence: true, length: {in: 2..38}
end
