module ManualSupport
  def check_manual(title, category, description)
    expect(page).to have_content(title)
    expect(page).to have_content(category)
    expect(page).to have_selector('img')
    expect(page).to have_content(description)
  end

  def check_no_manual(title, category, description)
    expect(page).to have_no_content(title)
    expect(page).to have_no_content(category)
    expect(page).to have_no_selector('img')
    expect(page).to have_no_content(description)
  end

  def edit_intro(manual)
    # マイページへのリンクが存在する
    expect(
      find('span[class="user-item"]').hover
    ).to have_link('マイページ', href: user_path(manual.user))
    # マイページに遷移する
    visit user_path(manual.user)
    # マイページに保存済みのマニュアルが存在する
    check_manual(manual.title, manual.category.name, manual.description)
    # 編集ページへのリンクが存在する
    expect(page).to have_content('編集')
    # 編集ページに遷移する
    visit edit_manual_path(manual)
  end

  def delete_intro(manual)
    # マイページへのリンクが存在する
    expect(
      find('span[class="user-item"]').hover
    ).to have_link('マイページ', href: user_path(manual.user))
    # マイページに遷移する
    visit user_path(manual.user)
    # マイページに保存済みのマニュアルが存在する
    check_manual(manual.title, manual.category_id, manual.description)
    # 削除ボタンが存在する
    expect(page).to have_content('削除')
  end

  def input_manual_true(title, text)
    fill_in 'manual_title', with: title
    find('select[name="manual[category_id]"]').click
    find('option[value="4"]').click
    fill_in 'manual_description', with: text
  end
end