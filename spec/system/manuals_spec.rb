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
      input_manual_true(@manual.title, @manual.description)
      manual_image_attach
      # 情報を送信すると、Manualモデルのカウントが1増加する
      expect {
        find('input[name="commit"]').click
      }.to change { Manual.count }.by(1)
      # マイページに遷移する
      expect(current_path).to eq(user_path(@user))
      # マイページに先ほど保存した内容が表示されている
      check_manual(@manual.title, 'その他', @manual.description)
    end

    it '（画像加工あり）正しい情報入力・画像保存・情報送信をすればマニュアルを新規作成できて、マイページに遷移する' do
      # ログインする
      sign_in(@user)
      # 新規作成ページへのリンクが存在する
      expect(page).to have_content('新規作成')
      # 新規作成ページに遷移する
      visit new_manual_path
      # 正しい情報を入力する
      input_manual_true(@manual.title, @manual.description)
      manual_image_attach
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
      check_manual(@manual.title, 'その他', @manual.description)
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
      # マイページに遷移する
      move_mypage(@manual1)
      # 編集ボタンが存在する
      edit_check(@manual1)
      # 正しい情報を入力する
      input_manual_true('NewTitle', 'NewText')
      # 情報を送信しても、Manualモデルのカウントは変化しない
      expect {
        find('input[name="commit"]').click
      }.to change { Manual.count }.by(0)
      # マイページに遷移する
      expect(current_path).to eq(manual_path(@manual1))
      # マイページに先ほど保存した内容が表示されている
      check_manual('NewTitle', 'その他', 'NewText')
    end
    
    it '（画像加工なし）正しい情報を入力すればマニュアルを編集できて、,マニュアル詳細ページに遷移する' do
      # manual1のユーザーでログインする
      sign_in(@manual1.user)
      # マイページに遷移する
      move_mypage(@manual1)
      # 編集ボタンが存在する
      edit_check(@manual1)
      # 正しい情報を入力する
      input_manual_true('NewTitle', 'NewText')
      manual_image_attach
      # 情報を送信しても、Manualモデルのカウントは変化しない
      expect {
        find('input[name="commit"]').click
      }.to change { Manual.count }.by(0)
      # マイページに遷移する
      expect(current_path).to eq(manual_path(@manual1))
      # マイページに先ほど保存した内容が表示されている
      check_manual('NewTitle', 'その他', 'NewText')
    end

    it '（画像加工あり）正しい情報入力・画像保存・情報送信をすればマニュアルを編集できて、マニュアル詳細ページに遷移する' do
      # manual1のユーザーでログインする
      sign_in(@manual1.user)
      # マイページに遷移する
      move_mypage(@manual1)
      # 編集ボタンが存在する
      edit_check(@manual1)
      # 正しい情報を入力する
      input_manual_true('NewTitle', 'NewText')
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
      check_manual('NewTitle', 'その他', 'NewText')
    end
  end

  context 'マニュアル編集ができないとき' do
    it '誤った情報を入力するとマニュアルを編集できず、入力フォームに戻ってくる' do
      # manual1のユーザーでログインする
      sign_in(@manual1.user)
      # マイページに遷移する
      move_mypage(@manual1)
      # 編集ボタンが存在する
      edit_check(@manual1)
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

    it '自分が作成したマニュアル以外は編集できない' do
      # manual1のユーザーでログインする
      sign_in(@manual1.user)
      # 編集ボタンの存在するページに遷移できない
      reject_user(@manual2)
    end
  end
end

RSpec.describe 'マニュアル削除', type: :system do
  before do
    @manual1 = FactoryBot.create(:manual)
    @manual2 = FactoryBot.create(:manual)
  end

  context 'マニュアル削除ができるとき' do
    it '作成者はマニュアルを削除できる' do
      # manual1のユーザーでログインする
      sign_in(@manual1.user)
      # マイページに遷移する
      move_mypage(@manual1)
      # 削除ボタンが存在する
      delete_check(@manual1)
      # 削除ボタンをクリックすると、Manualモデルのカウントが1減少する
      find_link('削除', href: manual_path(@manual1.id)).click
      expect {
        expect(page.accept_confirm).to eq('本当に削除しますか？')
        sleep 1
      }.to change { Manual.count }.by(-1)
      # マイページに遷移する
      expect(current_path).to eq(user_path(@manual1.user))
      # manual1の情報が存在しない
      check_no_manual(@manual1.title, @manual1.category.name, @manual1.description)
    end
  end

  context 'マニュアル削除ができないとき' do
    it '自分が作成したマニュアル以外は削除できない' do
      # manual1のユーザーでログインする
      sign_in(@manual1.user)
      # 削除ボタンの存在するページに遷移できない
      reject_user(@manual2)
    end
  end
end