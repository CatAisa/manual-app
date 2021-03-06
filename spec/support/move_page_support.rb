module MovePageSupport
  def move_mypage(manual)
    # マイページへのリンクが存在する
    expect(
      find('span[class="user-item"]').hover
    ).to have_link('マイページ', href: user_path(manual.user))
    # マイページに遷移する
    visit user_path(manual.user)
    # マイページに保存済みのマニュアルが存在する
    check_manual(manual.title, manual.category.name, manual.description)
  end

  def move_likepage(manual)
    # お気に入りページへのリンクが存在する
    expect(
      find('span[class="user-item"]').hover
    ).to have_link('お気に入り', href: user_likes_path(manual.user))
    # お気に入りページに遷移する
    visit user_likes_path(manual.user)
  end

  def move_show(manual)
    # マイページに遷移する
    move_mypage(manual)
    # マニュアル詳細ページへのリンクが存在する
    expect(page).to have_link(href: manual_path(manual))
    # マニュアル詳細ページに遷移する
    visit manual_path(manual)
  end

  def reject_user(manual)
    # manual2のマイページに遷移する
    visit user_path(manual.user)
    # 遷移できずにトップページに戻ってくる
    expect(current_path).to eq(root_path)
    # manual2の詳細ページに遷移する
    visit manual_path(manual)
    # 遷移できずにトップページに戻ってくる
    expect(current_path).to eq(root_path)
  end

  def move_useredit
    # トップページにユーザー名が存在する
    expect(page).to have_content('abcde12345')
    # ユーザー編集画面へのリンクが存在する
    expect(
      find('span[class="user-item"]').hover
    ).to have_link('編集', href: edit_user_registration_path)
    # ユーザー編集画面に遷移する
    visit edit_user_registration_path
  end

  def move_login
    # トップページに遷移する
    visit root_path
    # ログインボタンが存在する
    expect(page).to have_content('ログイン')
    # ログインページに遷移する
    visit new_user_session_path
  end
end