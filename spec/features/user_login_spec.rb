require 'rails_helper'

RSpec.feature "Visitor can login", type: :feature, js: true do

  before :each do
    @user = User.create!(
      name: 'First and Last Name',
      email: 'test@testing.com',
      password: 'pass12345',
      password_confirmation: 'pass12345'
    )
  end

  scenario "They can login" do
    # ACT
    visit '/login'

    within 'form' do

      fill_in id: 'email', with: @user.email
      fill_in id: 'password', with: @user.password

      click_on 'Submit'

      save_screenshot

    end

    # VERIFY
    expect(page).to have_content 'Products'
  end
end
