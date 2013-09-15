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
#  slug       :string(255)
#

class Organization < ActiveRecord::Base
  extend FriendlyId
  include Groupable
  friendly_id :name, use: :slugged
  has_many :seasons, dependent: :destroy
  validates :name, :contact, presence: true, length: {in: 2..38}
  alias_attribute :org_name, :name
  alias_attribute :org_about, :about
  alias_attribute :org_location, :location
end
