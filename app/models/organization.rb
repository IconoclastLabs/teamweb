# == Schema Information
#
# Table name: organizations
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  about      :string(255)
#  location   :string(255)
#  contact    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Organization < ActiveRecord::Base
  has_many :events, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :users, through: :members
  validates :name, :contact, presence: true, length: {in: 2..38}
end
