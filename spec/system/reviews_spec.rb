require 'rails_helper'

RSpec.describe 'レビュー投稿機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @manual = FactoryBot.create(:manual, user_id: @user.id)
    @review = FactoryBot.build(:review, user_id: @user.id, manual_id: @manual.id)
  end

  context 'レビューが投稿できるとき' do
    it '正しい情報を入力すればレビューを投稿できる' do
      # ログインする
      sign_in(@user)
      # マニュアル詳細ページに遷移するまで
      move_show(@manual)
      # 正しい情報を入力する
      fill_in 'review-text', with: @review.content
      # 情報を送信すると、Reviewモデルのカウントが1増加する
      expect {
        find('input[class="review-submit-btn"]').click
        sleep 1
      }.to change { Review.count }.by(1)
      # マニュアル詳細ページから移動しない
      expect(current_path).to eq(manual_path(@manual))
      # マニュアル詳細ページに先ほど投稿したレビュー情報が存在する
      expect(page).to have_content(@review.content)
    end
  end

  context 'レビューが投稿できないとき' do
    it '誤った情報を入力するとレビューを投稿できない' do
      # ログインする
      sign_in(@user)
      # マニュアル詳細ページに遷移するまで
      move_show(@manual)
      # 誤った情報を入力する
      fill_in 'review-text', with: ''
      # 情報を送信しても、Reviewモデルのカウントは変化しない
      expect {
        find('input[class="review-submit-btn"]').click
        sleep 1
      }.to change { Review.count }.by(0)
      # Error 204アラートが出る
      expect(page.accept_confirm).to have_content('Error 204')
      sleep 1
      # マニュアル詳細ページから移動しない
      expect(current_path).to eq(manual_path(@manual))
    end
  end
end

RSpec.describe 'レビュー削除機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @manual = FactoryBot.create(:manual, user_id: @user.id)
    @review = FactoryBot.create(:review, user_id: @user.id, manual_id: @manual.id)
    @release = FactoryBot.create(:release, user_id: @user.id, manual_id: @manual.id)
    @another_review = FactoryBot.create(:review, manual_id: @manual.id)
  end

  context 'レビューが削除できるとき' do
    it 'レビュー投稿者はレビューを削除できる' do
      # manualの作成者でログインする
      sign_in(@user)
      # マニュアル詳細ページに遷移するまで
      move_show(@manual)
      # 自分のレビューが存在する
      expect(page).to have_content(@review.content)
      # レビュー削除〜削除確認まで
      review_delete(@manual, @review)
    end

    it 'マニュアル作成者は自分のマニュアルに対するレビューを削除できる' do
      # manualの作成者でログインする
      sign_in(@user)
      # マニュアル詳細ページに遷移するまで
      move_show(@manual)
      # 他ユーザーのレビューが存在する
      expect(page).to have_content(@another_review.content)
      # レビュー削除〜削除確認まで
      review_delete(@manual, @another_review)
    end
  end

  context 'レビューが削除できないとき' do
    it 'レビュー投稿者以外かつマニュアル作成者以外のユーザーはレビューを削除できない' do
      # manual作成者以外ででログインする
      sign_in(@another_review.user)
      # トップページにマニュアル詳細ページへのリンクが存在する
      expect(page).to have_link(href: manual_path(@manual))
      # マニュアル詳細ページに遷移する
      visit manual_path(@manual)
      # 他ユーザーのレビューが存在する
      expect(page).to have_content(@review.content)
      # レビューに削除ボタンが存在しない
      expect(page).to have_no_link('削除', href: manual_review_path(@manual, @review))
    end
  end
end