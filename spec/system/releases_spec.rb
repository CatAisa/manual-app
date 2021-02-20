require 'rails_helper'

RSpec.describe 'マニュアルの一般公開', type: :system do
  before do
    @manual1 = FactoryBot.create(:manual)
    @manual2 = FactoryBot.create(:manual)
  end

  context '一般公開できるとき' do
    it '作成者はマニュアルを一般公開できる' do
      # manual1のユーザーでログインする
      sign_in(@manual1.user)
      # マイページに遷移する
      move_mypage(@manual1)
      # 「一般公開する」ボタンが存在する
      expect(page).to have_link('一般公開する', href: manual_releases_path(@manual1))
      # 「一般公開する」ボタンをクリックすると、Releaseモデルのカウントが1増加する
      find_link('一般公開する', href: manual_releases_path(@manual1)).click
      expect {
        expect(page.accept_confirm).to have_content("本当によろしいですか？")
        sleep 1
      }.to change { Release.count }.by(1)
      # マニュアル詳細ページに遷移する
      expect(current_path).to eq(manual_path(@manual1))
      # 「非公開にする」ボタンが存在する
      expect(page).to have_link('非公開にする', href: manual_release_path(@manual1, @manual1.release))
      # トップページに公開したマニュアル情報が存在する
      visit root_path
      check_manual(@manual1.title, @manual1.category.name, @manual1.description)
    end
  end

  context '一般公開できないとき' do
    it '作成者以外はマニュアルを一般公開できない' do
      # manual1のユーザーでログインする
      sign_in(@manual1.user)
      # 一般公開ボタンの存在するページに遷移できない
      reject_user(@manual2)
    end
  end
end

RSpec.describe 'マニュアルの非公開', type: :system do
  before do
    @manual1 = FactoryBot.create(:manual)
    @release1 = FactoryBot.create(:release, user_id: @manual1.user.id, manual_id: @manual1.id)
    @manual2 = FactoryBot.create(:manual)
    @release2 = FactoryBot.create(:release, user_id: @manual2.user.id, manual_id: @manual2.id)
  end

  context '非公開にできるとき' do
    it '作成者はマニュアルを非公開にできる' do
      # manual1のユーザーでログインする
      sign_in(@manual1.user)
      # トップページに公開されたmanual1に「非公開にする」ボタンが存在する
      expect(page).to have_link('非公開にする', href: manual_release_path(@manual1, @manual1.release))
      # 「非公開にする」ボタンをクリックすると、Releaseモデルのカウントが1減少する
      expect {
        find_link('非公開にする', href: manual_release_path(@manual1, @manual1.release)).click
      }.to change { Release.count }.by(-1)
      # マニュアル詳細ページに遷移する
      expect(current_path).to eq(manual_path(@manual1))
      # 「一般公開する」ボタンが存在する
      expect(page).to have_link('一般公開する', href: manual_releases_path(@manual1))
    end
  end

  context '非公開にできないとき' do
    it '作成者以外はマニュアルを非公開にできない' do
      # manual1のユーザーでログインする
      sign_in(@manual1.user)
      # トップページに公開されたmanual2に「非公開にする」ボタンが存在しない
      expect(page).to have_no_link('非公開にする', href: manual_release_path(@manual2, @manual2.release))
    end
  end
end