module Groupable
  extend ActiveSupport::Concern

  # This code runs in the context of the target class
  included do
    has_many :members, dependent: :destroy, as: :groupable
    has_many :users, through: :members
  end
  
  def add_member(user, admin_flag: false)
    Member.transaction do
      self.members.add_member(user, admin_flag: admin_flag)
      #should_raise = self.max_members && self.members.size > self.max_members
      #raise ActiveRecord::Rollback, "Max members met" if should_raise
      true
    end # end Transaction
  end
end