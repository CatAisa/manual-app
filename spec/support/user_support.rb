module UserSupport
  def input_user(nickname, email, password)
    fill_in 'user_nickname', with: nickname
    fill_in 'user_email', with: email
    fill_in 'user_password', with: password
    fill_in 'user_password_confirmation', with: password
  end
end