module ManualSupport
  def check_manual(title, category, description)
    expect(page).to have_content(title)
    expect(page).to have_content(category)
    expect(page).to have_selector('img')
    expect(page).to have_content(description)
  end

  def edit_intro(manual)
    # マイページへのリンクが存在する
    expect(
      find('span[class="user-item"]').hover
    ).to have_link('マイページ', href: user_path(manual.user))
    # マイページに遷移する
    visit user_path(manual.user)
    # マイページに保存済みのマニュアルが存在する
    check_manual(manual.title, manual.category_id, manual.description)
    # 編集ページへのリンクが存在する
    expect(page).to have_content('編集')
    # 編集ページに遷移する
    visit edit_manual_path(manual)
  end

  def input_manual_true(title, text)
    fill_in 'manual_title', with: title
    find('select[name="manual[category_id]"]').click
    find('option[value="4"]').click
    fill_in 'manual_description', with: text
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
end