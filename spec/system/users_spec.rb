require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができて、トップページに遷移する' do
      # トップページに遷移する
      visit root_path
      # トップページに新規登録画面に遷移するボタンがある
      expect(page).to have_content('新規登録')
      # 新規登録ページに移動する
      visit new_user_registration_path
      # 正しいユーザー情報を入力する
      fill_in 'user_nickname', with: @user.nickname
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      fill_in 'user_password_confirmation', with: @user.password_confirmation
      # ユーザー情報を送信するとUserモデルのカウントが1増える
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # トップページに遷移する
      expect(current_path).to eq(root_path)
      # トップページにユーザー名が存在する
      expect(page).to have_content(@user.nickname)
      # トップページにログアウトボタンが存在する
      expect(page).to have_content('ログアウト')
      # トップページにログインボタンが存在しない
      expect(page).to have_no_content('ログイン')
      # トップページに新規登録ボタンが存在しない
      expect(page).to have_no_content('新規登録')
    end
  end

  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができず、新規登録ページに戻ってくる' do
      # トップページに遷移する
      visit root_path
      # トップページに新規登録画面に遷移するボタンがある
      expect(page).to have_content('新規登録')
      # 新規登録ページに移動する
      visit new_user_registration_path
      # 誤ったユーザー情報を入力する
      fill_in 'user_nickname', with: ''
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      fill_in 'user_password_confirmation', with: ''
      # ユーザー情報を送信してもUserモデルのカウントが増えない
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページに戻される
      expect(current_path).to eq('/users')
      # 新規登録ページにエラー文が表示されている
      expect(page).to have_content('Eメールを入力してください')
      expect(page).to have_content('パスワードを入力してください')
      expect(page).to have_content('ニックネームを入力してください')
    end
  end
end

RSpec.describe 'ログイン、ログアウト', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ログインができるとき' do
    it '登録済みのユーザー情報ならばログインできて、トップページに遷移する' do
      # トップページに遷移する
      visit root_path
      # ログインボタンが存在する
      expect(page).to have_content('ログイン')
      # ログインページに遷移する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      # ユーザー情報を送信すると、トップページに遷移する
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # トップページにユーザー名が存在する
      expect(page).to have_content(@user.nickname)
      # トップページにログアウトボタンが存在する
      expect(page).to have_content('ログアウト')
      # ログアウトボタンをクリックすると、トップページに遷移する
      find_link('ログアウト', href: destroy_user_session_path).click
      expect(current_path).to eq(root_path)
      # トップページにログインボタンが存在する
      expect(page).to have_content('ログイン')
      # トップページに新規登録ボタンが存在する
      expect(page).to have_content('新規登録')
    end
  end

  context 'ログインができないとき' do
    it '誤った情報ではログインできず、ログインページに戻ってくる' do
      # トップページに遷移する
      visit root_path
      # ログインボタンが存在する
      expect(page).to have_content('ログイン')
      # ログインページに遷移する
      visit new_user_session_path
      # 誤ったユーザー情報を入力する
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      # ユーザー情報を送信すると、ログインページに遷移する
      find('input[name="commit"]').click
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
