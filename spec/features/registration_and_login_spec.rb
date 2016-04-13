require 'rails_helper'

feature 'User registration and authentication' do
  scenario 'allows user to register an account' do
    visit '/'

    click_on 'Registrieren'

    fill_in 'Email',                      with: 's007@htw-berlin.de'
    fill_in 'user_password',              with: 'secret-password'
    fill_in 'user_password_confirmation', with: 'secret-password'

    expect {
      click_on 'Sign up'
    }.to change(User, :count).by(1)

    user = User.last
    expect(user.email).to eq 's007@htw-berlin.de'
    expect(user).not_to be_confirmed

    email = ActionMailer::Base.deliveries.last
    expect(email.to.first).to eq 's007@htw-berlin.de'

    confirmation_link = email.body.match %r{href="(.+)"}
    visit confirmation_link[1]

    confirmed_user = User.last
    expect(confirmed_user).to be_confirmed
  end
end
