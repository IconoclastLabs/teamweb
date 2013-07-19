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
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  let(:simple_user) {User.new(email: 'testemail@gmail.com', password: '12345678')}
  it 'can create a new User' do
    simple_user.valid?.must_equal true
  end

  it 'requires a password of at least 8 characters' do
    simple_user.password = "x" * 7
    simple_user.valid?.must_equal false
  end

  it 'warns you if you try to duplicate email' do
    @existing_user = users(:one)
    @existing_user.id = nil
    @existing_user.valid?.must_equal false
  end
end
