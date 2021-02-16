module ManualSupport
  def edit_intro(manual)
    # マイページへのリンクが存在する
    expect(
      find('span[class="user-item"]').hover
    ).to have_link('マイページ', href: user_path(manual.user))
    # マイページに遷移する
    visit user_path(manual.user)
    # マイページに保存済みのマニュアルが存在する
    expect(page).to have_content(manual.title)
    expect(page).to have_content(manual.category_id)
    expect(page).to have_selector('img')
    expect(page).to have_content(manual.description)
    # 編集ページへのリンクが存在する
    expect(page).to have_content('編集')
    # 編集ページに遷移する
    visit edit_manual_path(manual)
  end
end