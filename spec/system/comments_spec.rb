require 'rails_helper'

RSpec.describe 'コメント投稿機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @manual = FactoryBot.create(:manual, user_id: @user.id)
    @procedure = FactoryBot.create(:procedure, user_id: @user.id, manual_id: @manual.id)
    @comment = FactoryBot.build(:comment, user_id: @user.id, manual_id: @manual.id, procedure_id: @procedure.id)
  end

  context 'コメントが投稿できるとき' do
    it '正しい情報を入力すればコメントを投稿できる' do
      # ログインする
      sign_in(@user)
      # マニュアル詳細ページに遷移するまで
      move_show(@manual)
      # 正しい情報を入力する
      fill_in "comment-text#{@procedure.id}", with: @comment.content
      # 情報を送信すると、Commentモデルのカウントが1増加する
      expect {
        find('input[class="comment-submit-btn"]').click
        sleep 1
      }.to change { Comment.count }.by(1)
      # マニュアル詳細ページから移動しない
      expect(current_path).to eq(manual_path(@manual))
      # マニュアル詳細ページに先ほど投稿したコメント情報が存在する
      expect(page).to have_content(@comment.content)
    end
  end

  context 'コメントが投稿できないとき' do
    it '誤った情報を入力するとコメントを投稿できない' do
      # ログインする
      sign_in(@user)
      # マニュアル詳細ページに遷移するまで
      move_show(@manual)
      # 誤った情報を入力する
      fill_in "comment-text#{@procedure.id}", with: ''
      # 情報を送信しても、Commentモデルのカウントは変化しない
      expect {
        find('input[class="comment-submit-btn"]').click
        sleep 1
      }.to change { Comment.count }.by(0)
      # Error 204アラートが出る
      expect(page.accept_confirm).to have_content('Error 204')
      sleep 1
      # マニュアル詳細ページから移動しない
      expect(current_path).to eq(manual_path(@manual))
    end
  end
end

RSpec.describe 'コメント削除機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @manual = FactoryBot.create(:manual, user_id: @user.id)
    @procedure = FactoryBot.create(:procedure, user_id: @user.id, manual_id: @manual.id)
    @comment = FactoryBot.create(:comment, user_id: @user.id, manual_id: @manual.id, procedure_id: @procedure.id)
    @release = FactoryBot.create(:release, user_id: @user.id, manual_id: @manual.id)
    @another_comment = FactoryBot.create(:comment, manual_id: @manual.id, procedure_id: @procedure.id)
  end

  context 'コメントが削除できるとき' do
    it 'コメント投稿者はコメントを削除できる' do
      # manualの作成者でログインする
      sign_in(@user)
      # マニュアル詳細ページに遷移するまで
      move_show(@manual)
      # 自分のコメントが存在する
      expect(page).to have_content(@comment.content)
      # コメント削除〜削除確認まで
      comment_delete(@manual, @procedure, @comment)
    end

    it 'マニュアル作成者は自分のマニュアルに対するコメントを削除できる' do
      # manualの作成者でログインする
      sign_in(@user)
      # マニュアル詳細ページに遷移するまで
      move_show(@manual)
      # 他ユーザーのコメントが存在する
      expect(page).to have_content(@another_comment.content)
      # コメント削除〜削除確認まで
      comment_delete(@manual, @procedure, @another_comment)
    end
  end

  context 'コメントが削除できないとき' do
    it 'コメント投稿者以外かつマニュアル作成者以外のユーザーはコメントを削除できない' do
      # manual作成者以外ででログインする
      sign_in(@another_comment.user)
      # トップページにマニュアル詳細ページへのリンクが存在する
      expect(page).to have_link(href: manual_path(@manual))
      # マニュアル詳細ページに遷移する
      visit manual_path(@manual)
      # 他ユーザーのコメントが存在する
      expect(page).to have_content(@comment.content)
      # コメントに削除ボタンが存在しない
      expect(page).to have_no_link('削除', href: manual_procedure_comment_path(@manual, @procedure, @comment))
    end
  end
end