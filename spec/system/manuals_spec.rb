require 'rails_helper'

RSpec.describe 'マニュアル新規作成', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @manual = FactoryBot.build(:manual)
  end

  context 'マニュアル新規作成ができるとき' do
    it '（画像加工なし）正しい情報を入力すればマニュアルを新規作成できて、マイページに遷移する' do
      # ログインする
      sign_in(@user)
      # 新規作成ページへのリンクが存在する
      expect(page).to have_content('新規作成')
      # 新規作成ページに遷移する
      visit new_manual_path
      # 正しい情報を入力する
      fill_in 'manual_title', with: @manual.title
      find('select[name="manual[category_id]"]').click
      find('option[value="4"]').click
      manual_image_attach
      fill_in 'manual_description', with: @manual.description
      # 情報を送信すると、Manualモデルのカウントが1増加する
      expect {
        find('input[name="commit"]').click
      }.to change { Manual.count }.by(1)
      # マイページに遷移する
      expect(current_path).to eq(user_path(@user))
      # マイページに先ほど保存した内容が表示されている
      created_manual(@manual)
    end

    it '（画像加工あり）正しい情報入力・画像保存・情報送信をすればマニュアルを新規作成できて、マイページに遷移する' do
      # ログインする
      sign_in(@user)
      # 新規作成ページへのリンクが存在する
      expect(page).to have_content('新規作成')
      # 新規作成ページに遷移する
      visit new_manual_path
      # 正しい情報を入力する
      fill_in 'manual_title', with: @manual.title
      find('select[name="manual[category_id]"]').click
      find('option[value="4"]').click
      manual_image_attach
      fill_in 'manual_description', with: @manual.description
      # 画像保存をクリックする
      find('span[id="image-save"]').click
      # 「編集画像を保存しました」の記述が存在する
      expect(page).to have_content('編集画像を保存しました')
      # 情報を送信すると、Manualモデルのカウントが1増加する
      expect {
        find('input[name="commit"]').click
      }.to change { Manual.count }.by(1)
      # マイページに遷移する
      expect(current_path).to eq(user_path(@user))
      # マイページに先ほど保存した内容が表示されている
      created_manual(@manual)
    end
  end

  context 'マニュアル新規作成ができないとき' do
    it '誤った情報を入力するとマニュアルを新規作成できず、入力フォームに戻ってくる' do
      # ログインする
      sign_in(@user)
      # 新規作成ページへのリンクが存在する
      expect(page).to have_content('新規作成')
      # 新規作成ページに遷移する
      visit new_manual_path
      # 誤った情報を入力する
      fill_in 'manual_title', with: ''
      fill_in 'manual_description', with: ''
      # 情報を送信してもManualモデルのカウントは変化しない
      expect {
        find('input[name="commit"]').click
      }.to change { Manual.count }.by(0)
      # 入力フォームに戻ってくる
      expect(current_path).to eq('/manuals')
      # 入力フォームにエラー文が表示されている
      expect(page).to have_content('マニュアル名を入力してください')
      expect(page).to have_content('カテゴリーを選択してください')
    end
  end
end

RSpec.describe 'マニュアル編集', type: :system do
  before do
    @manual1 = FactoryBot.create(:manual)
    @manual2 = FactoryBot.create(:manual)
  end

  context 'マニュアル編集ができるとき' do
    it '（画像編集なし）正しい情報を入力すればマニュアルを編集できて、,マニュアル詳細ページに遷移する' do
      # manual1のユーザーでログインする
      sign_in(@manual1.user)
      # 編集情報の入力手前まで
      edit_intro(@manual1)
      # 正しい情報を入力する
      input_manual_true
      # 情報を送信しても、Manualモデルのカウントは変化しない
      expect {
        find('input[name="commit"]').click
      }.to change { Manual.count }.by(0)
      # マイページに遷移する
      expect(current_path).to eq(manual_path(@manual1))
      # マイページに先ほど保存した内容が表示されている
      edited_manual
    end
    it '（画像加工なし）正しい情報を入力すればマニュアルを編集できて、,マニュアル詳細ページに遷移する' do
      # manual1のユーザーでログインする
      sign_in(@manual1.user)
      # 編集情報の入力手前まで
      edit_intro(@manual1)
      # 正しい情報を入力する
      input_manual_true
      manual_image_attach
      # 情報を送信しても、Manualモデルのカウントは変化しない
      expect {
        find('input[name="commit"]').click
      }.to change { Manual.count }.by(0)
      # マイページに遷移する
      expect(current_path).to eq(manual_path(@manual1))
      # マイページに先ほど保存した内容が表示されている
      edited_manual
    end

    it '（画像加工あり）正しい情報入力・画像保存・情報送信をすればマニュアルを編集できて、マニュアル詳細ページに遷移する' do
      # manual1のユーザーでログインする
      sign_in(@manual1.user)
      # 編集情報の入力手前まで
      edit_intro(@manual1)
      # 正しい情報を入力する
      input_manual_true
      manual_image_attach
      # 画像保存をクリックする
      find('span[id="image-save"]').click
      # 「編集画像を保存しました」の記述が存在する
      expect(page).to have_content('編集画像を保存しました')
      # 情報を送信しても、Manualモデルのカウントは変化しない
      expect {
        find('input[name="commit"]').click
      }.to change { Manual.count }.by(0)
      # マイページに遷移する
      expect(current_path).to eq(manual_path(@manual1))
      # マイページに先ほど保存した内容が表示されている
      edited_manual
    end
  end

  context 'マニュアル編集ができないとき' do
    it '誤った情報を入力するとマニュアルを編集できず、入力フォームに戻ってくる' do
      # manual1のユーザーでログインする
      sign_in(@manual1.user)
      # 編集情報の入力手前まで
      edit_intro(@manual1)
      # 誤った情報を入力する
      fill_in 'manual_title', with: ''
      find('select[name="manual[category_id]"]').click
      find('option[value="0"]').click
      fill_in 'manual_description', with: ''
      # 情報を送信してもManualモデルのカウントは変化しない
      expect {
        find('input[name="commit"]').click
      }.to change { Manual.count }.by(0)
      # 入力フォームに戻ってくる
      expect(current_path).to eq("/manuals/#{@manual1.id}/edit")
    end
  end
end
