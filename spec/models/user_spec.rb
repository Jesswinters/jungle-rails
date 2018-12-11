require 'rails_helper'

RSpec.describe User, type: :model do

  before :each do
    @user = User.create!({
      name: 'Person',
      email: 'test@test.com',
      password: 'test1234',
      password_confirmation: 'test1234'
    })

    @authenticatedUser = User.create!(
      name: 'Authenticated',
      email: 'auth@user.com',
      password: 'authed1234',
      password_confirmation: 'authed1234'
    )
  end

  describe 'Validations' do

    it 'matches password and password confirmation' do
      @user.password == @user.password_confirmation

      expect(@user).to be_valid
      @user.destroy
    end

    it 'requires email and name' do
      @user.name = nil
      @user.email = nil

      expect(@user).to_not be_valid
      @user.destroy
    end

    it 'does not match password and password confirmation' do
      @user.password = 'test1234'
      @user.password_confirmation = 'test12345'

      expect(@user.password).to_not eql(@user.password_confirmation)
      @user.destroy
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
      @user.destroy
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
      @user.destroy
    end

  end

  describe '.authenticate_with_credentials' do

    it 'should return an instance of user when login credentials correct' do
      expect(User.authenticate_with_credentials('auth@user.com', 'authed1234')).to eq @authenticatedUser
      @user.destroy
    end

    it 'should login user when there are space in front of their email address' do
      expect(User.authenticate_with_credentials('  auth@user.com', 'authed1234')).to eq @authenticatedUser
      @user.destroy
    end

    it 'should login user when they type in the wrong case for their email address' do
      expect(User.authenticate_with_credentials('aUtH@user.COM', 'authed1234')).to eq @authenticatedUser
      @user.destroy
    end

    it 'should not authenticate with the wrong password' do
      expect(User.authenticate_with_credentials('auth@user.com', 'authed12345')).to_not eq @authenticatedUser
      @user.destroy
    end

    it 'should not authenticate with the wrong email' do
      expect(User.authenticate_with_credentials('notauth@user.com', 'authed1234')).to_not eq @authenticatedUser
      @user.destroy
    end

  end

end
