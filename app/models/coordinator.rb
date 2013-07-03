# == Schema Information
#
# Table name: coordinators
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  about      :string(255)
#  location   :string(255)
#  contact    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Coordinator < ActiveRecord::Base
  has_many :events
  validates :name, presence: true
end
