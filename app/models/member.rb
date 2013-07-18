class Member < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
  belongs_to :event
  belongs_to :team
end
