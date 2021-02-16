require 'rails_helper'

RSpec.describe "手順新規作成", type: :system do
  before do
    @manual = FactoryBot.create(:manual)
    @procedure = FactoryBot.build(:procedure)
  end

  context 'マニュアル新規作成ができるとき' do
    it '（画像加工なし）正しい情報を入力すれば手順を新規作成できて、マニュアル詳細ページに遷移する' do
      # ログインする
      sign_in(@manual.user)
      # マニュアル詳細ページに遷移するまで
      move_show(@manual)
      # 新規作成ページへのリンクが存在する
      expect(page).to have_content('手順を追加')
      # 新規作成ページに遷移する
      visit new_manual_procedure_path(@manual)
      # 正しい情報を入力する
      input_procedure_true(@procedure.title, @procedure.description)
      procedure_image_attach
      # 情報を送信すると、Procedureモデルのカウントが1増加する
      expect {
        find('input[name="commit"]').click
      }.to change { Procedure.count }.by(1)
      # マニュアル詳細ページに遷移する
      expect(current_path).to eq(manual_path(@manual))
      # マイページに先ほど保存した内容が表示されている
      check_procedure(@procedure.title, @procedure.description)
    end

    it '（画像加工あり）正しい情報入力・画像保存・情報送信をすれば手順新規作成できて、マニュアル詳細ページに遷移する' do
      # ログインする
      sign_in(@manual.user)
      # マニュアル詳細ページに遷移するまで
      move_show(@manual)
      # 新規作成ページへのリンクが存在する
      expect(page).to have_content('手順を追加')
      # 新規作成ページに遷移する
      visit new_manual_procedure_path(@manual)
      # 正しい情報を入力する
      input_procedure_true(@procedure.title, @procedure.description)
      procedure_image_attach
      # 画像保存をクリックする
      find('span[id="image-save"]').click
      # 「編集画像を保存しました」の記述が存在する
      expect(page).to have_content('編集画像を保存しました')
      # 情報を送信すると、Procedureモデルのカウントが1増加する
      expect {
        find('input[name="commit"]').click
      }.to change { Procedure.count }.by(1)
      # マニュアル詳細ページに遷移する
      expect(current_path).to eq(manual_path(@manual))
      # マイページに先ほど保存した内容が表示されている
      check_procedure(@procedure.title, @procedure.description)
    end
  end

  context '手順新規作成ができないとき' do
    it '誤った情報を入力すると手順を新規作成できず、入力フォームに戻ってくる' do
      # ログインする
      sign_in(@manual.user)
      # マニュアル詳細ページに遷移するまで
      move_show(@manual)
      # 新規作成ページへのリンクが存在する
      expect(page).to have_content('手順を追加')
      # 新規作成ページに遷移する
      visit new_manual_procedure_path(@manual)
      # 誤った情報を入力する
      fill_in 'procedure_title', with: ''
      fill_in 'procedure_description', with: ''
      # 情報を送信してもProcedureモデルのカウントは変化しない
      expect {
        find('input[name="commit"]').click
      }.to change { Procedure.count }.by(0)
      # 入力フォームに戻ってくる
      expect(current_path).to eq("/manuals/#{@manual.id}/procedures")
      # 入力フォームにエラー文が表示されている
      expect(page).to have_content('タイトルを入力してください')
    end
  end
end
