module GuestSupport
  def guest_login_first(button_name, user_name, guest_id)
    # ログインページに移動するまで
    move_login
    # 「ゲスト１(２)でログインする」ボタンが存在する
    expect(page).to have_link("#{button_name}でログイン", href: users_guest_sign_in_path(guest_id: guest_id))
    # 「ゲスト１(２)でログインする」ボタンをクリックすると、Userモデルのカウントが1増加する
    expect {
      find_link("#{button_name}でログイン", href: users_guest_sign_in_path(guest_id: guest_id)).click
    }.to change { User.count }.by(1)
    # トップページに遷移する
    expect(current_path).to eq(root_path)
    # トップページにguest1(2)が存在する
    expect(page).to have_content(user_name)
    # トップページにログアウトボタンが存在する
    expect(page).to have_content('ログアウト')
  end

  def guest_login_again(button_name, user_name, guest_id)
    FactoryBot.create(:user, nickname: user_name, email: "#{user_name}@example.com")
    # ログインページに移動するまで
    move_login
    # 「ゲスト１(２)でログインする」ボタンが存在する
    expect(page).to have_link("#{button_name}でログイン", href: users_guest_sign_in_path(guest_id: guest_id))
    # 「ゲスト１(２)でログインする」ボタンをクリックしても、Userモデルのカウントは変化しない
    expect {
      find_link("#{button_name}でログイン", href: users_guest_sign_in_path(guest_id: guest_id)).click
    }.to change { User.count }.by(0)
    # トップページに遷移する
    expect(current_path).to eq(root_path)
    # トップページにguest1(2)が存在する
    expect(page).to have_content(user_name)
    # トップページにログアウトボタンが存在する
    expect(page).to have_content('ログアウト')
  end
end