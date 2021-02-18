require 'rails_helper'

RSpec.describe 'お気に入り登録', type: :system do
  before do
    @manual1 = FactoryBot.create(:manual)
    @release1 = FactoryBot.create(:release, user_id: @manual1.user.id, manual_id: @manual1.id)
    @manual2 = FactoryBot.create(:manual)
    @release2 = FactoryBot.create(:release, user_id: @manual2.user.id, manual_id: @manual2.id)
  end

  context 'お気に入り登録できるとき' do
    it '自分以外のマニュアルをお気に入り登録できる' do
      # manual1のユーザーでログインする
      sign_in(@manual1.user)
      # トップページに公開されているマニュアルの情報が表示されている
      check_manual(@manual1.title, @manual1.category.name, @manual1.description)
      check_manual(@manual2.title, @manual2.category.name, @manual2.description)
      # manual2にお気に入りボタンが存在する
      expect(page).to have_link(href: manual_likes_path(@manual2))
      # お気に入りボタンをクリックすると、Likeモデルのカウントが1増加する
      expect {
        find_link(href: manual_likes_path(@manual2)).click
      }.to change { Like.count }.by(1)
      # トップ画面に遷移する
      expect(current_path).to eq(root_path)
      # お気に入りページに遷移する
      move_likepage(@manual1)
      # お気に入りページに先ほど登録したマニュアルの情報が表示されている
      check_manual(@manual2.title, @manual2.category.name, @manual2.description)
    end
  end

  context 'お気に入り登録できないとき' do
    it '作成者は自分のマニュアルをお気に入り登録ができない' do
      # manual1のユーザーでログインする
      sign_in(@manual1.user)
      # トップページに公開されているマニュアルの情報が表示されている
      check_manual(@manual1.title, @manual1.category.name, @manual1.description)
      check_manual(@manual2.title, @manual2.category.name, @manual2.description)
      # manual1にお気に入りボタンが存在しない
      expect(page).to have_no_link(href: manual_likes_path(@manual1))
    end
  end
end
