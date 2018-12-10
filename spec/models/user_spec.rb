require 'rails_helper'

RSpec.describe User, type: :model do

  before :each do
    @user = User.create!({
      name: 'Person',
      email: 'test@test.com',
      password: 'test1234',
      password_confirmation: 'test1234'
    })
  end

  describe 'Validations' do

    it 'matches password and password confirmation' do
      @user.password == @user.password_confirmation

      expect(@user).to be_valid
    end

    it 'requires email and name' do
      @user.name = nil
      @user.email = nil

      expect(@user).to_not be_valid
    end

    it 'does not match password and password confirmation' do
      @user.password = 'test1234'
      @user.password_confirmation = 'test12345'

      expect(@user.password).to_not eql(@user.password_confirmation)
    end

    it 'should only allow unique emails' do
      @user1 = User.create(
        name: 'Newbie',
        email: 'test1@test.com',
        password: 'testing1234',
        password_confirmation: 'testing1234'
      )

      @user2 = User.create(
        name: 'Newbie',
        email: 'test1@test.com',
        password: 'testing1234',
        password_confirmation: 'testing1234'
      )

      expect(@user1).to be_valid
      expect(@user2).to_not be_valid
    end

    it 'should only allow unique emails, regardless of case (not case sensitive)' do
      @user3 = User.create(
        name: 'Newbie',
        email: 'test3@test.com',
        password: 'testing1234',
        password_confirmation: 'testing1234'
      )

      @user4 = User.create(
        name: 'Newbie',
        email: 'TEST3@TEST.com',
        password: 'testing1234',
        password_confirmation: 'testing1234'
      )

      expect(@user3).to be_valid
      expect(@user4).to_not be_valid
    end

    it 'should have a minimum length for password' do

    end

  end

end
