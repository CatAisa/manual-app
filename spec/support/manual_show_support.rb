module ManualShowSupport
  def move_show(manual)
    # マイページへのリンクが存在する
    expect(
      find('span[class="user-item"]').hover
    ).to have_link('マイページ', href: user_path(manual.user))
    # マイページに遷移する
    visit user_path(manual.user)
    # マニュアル詳細ページへのリンクが存在する
    expect(page).to have_link(href: manual_path(manual))
    # マニュアル詳細ページに遷移する
    visit manual_path(manual)
  end
end