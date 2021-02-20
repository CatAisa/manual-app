require 'rails_helper'

RSpec.describe "手順新規作成", type: :system do
  before do
    @manual = FactoryBot.create(:manual)
    @procedure = FactoryBot.build(:procedure)
  end

  context '手順新規作成ができるとき' do
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

RSpec.describe '手順編集', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @manual1 = FactoryBot.create(:manual, user_id: @user1.id)
    @procedure1 = FactoryBot.create(:procedure, user_id: @user1.id, manual_id: @manual1.id)
    @user2 = FactoryBot.create(:user)
    @manual2 = FactoryBot.create(:manual, user_id: @user2.id)
    @procedure2 = FactoryBot.create(:procedure, user_id: @user2.id, manual_id: @manual2.id)
  end

  context '手順編集ができるとき' do
    it '（画像編集なし）正しい情報を入力すれば手順を編集できて、,マニュアル詳細ページに遷移する' do
      # procedure1のユーザーでログインする
      sign_in(@user1)
      # マニュアル詳細ページに遷移するまで
      move_show(@manual1)
      # 編集ページへのリンクが存在する
      expect(page).to have_link('編集', href: edit_manual_procedure_path(@manual1, @procedure1))
      # 編集ページに遷移する
      visit edit_manual_procedure_path(@manual1, @procedure1)
      # 正しい情報を入力する
      input_procedure_true('NewTitle', 'NewText')
      # 情報を送信しても、Procedureモデルのカウントは変化しない
      expect {
        find('input[name="commit"]').click
      }.to change { Procedure.count }.by(0)
      # マニュアル詳細ページに遷移する
      expect(current_path).to eq(manual_path(@manual1))
      # マイページに先ほど保存した内容が表示されている
      check_procedure('NewTitle', 'NewText')
    end

    it '（画像加工なし）正しい情報を入力すれば手順を編集できて、,マニュアル詳細ページに遷移する' do
      # procedure1のユーザーでログインする
      sign_in(@user1)
      # マニュアル詳細ページに遷移するまで
      move_show(@manual1)
      # 編集ページへのリンクが存在する
      expect(page).to have_link('編集', href: edit_manual_procedure_path(@manual1, @procedure1))
      # 編集ページに遷移する
      visit edit_manual_procedure_path(@manual1, @procedure1)
      # 正しい情報を入力する
      input_procedure_true('NewTitle', 'NewText')
      procedure_image_attach
      # 情報を送信しても、Procedureモデルのカウントは変化しない
      expect {
        find('input[name="commit"]').click
      }.to change { Procedure.count }.by(0)
      # マニュアル詳細ページに遷移する
      expect(current_path).to eq(manual_path(@manual1))
      # マイページに先ほど保存した内容が表示されている
      check_procedure('NewTitle', 'NewText')
    end

    it '（画像加工あり）正しい情報入力・画像保存・情報送信をすれば手順を編集できて、マニュアル詳細ページに遷移する' do
      # procedure1のユーザーでログインする
      sign_in(@user1)
      # マニュアル詳細ページに遷移するまで
      move_show(@manual1)
      # 編集ページへのリンクが存在する
      expect(page).to have_link('編集', href: edit_manual_procedure_path(@manual1, @procedure1))
      # 編集ページに遷移する
      visit edit_manual_procedure_path(@manual1, @procedure1)
      # 正しい情報を入力する
      input_procedure_true('NewTitle', 'NewText')
      procedure_image_attach
      # 画像保存をクリックする
      find('span[id="image-save"]').click
      # 「編集画像を保存しました」の記述が存在する
      expect(page).to have_content('編集画像を保存しました')
      # 情報を送信しても、Procedureモデルのカウントは変化しない
      expect {
        find('input[name="commit"]').click
      }.to change { Procedure.count }.by(0)
      # マニュアル詳細ページに遷移する
      expect(current_path).to eq(manual_path(@manual1))
      # マイページに先ほど保存した内容が表示されている
      check_procedure('NewTitle', 'NewText')
    end
  end

  context '手順編集ができないとき' do
    it '誤った情報を入力すると手順を編集できず、入力フォームに戻ってくる' do
      # procedure1のユーザーでログインする
      sign_in(@user1)
      # マニュアル詳細ページに遷移するまで
      move_show(@manual1)
      # 編集ページへのリンクが存在する
      expect(page).to have_link('編集', href: edit_manual_procedure_path(@manual1, @procedure1))
      # 編集ページに遷移する
      visit edit_manual_procedure_path(@manual1, @procedure1)
      # 誤った情報を入力する
      fill_in 'procedure_title', with: ''
      fill_in 'procedure_description', with: ''
      # 情報を送信してもProcedureモデルのカウントは変化しない
      expect {
        find('input[name="commit"]').click
      }.to change { Procedure.count }.by(0)
      # 入力フォームに戻ってくる
      expect(current_path).to eq("/manuals/#{@manual1.id}/procedures/#{@procedure1.id}/edit")
    end

    it '自分が作成したマニュアル以外は編集できない' do
      # procedure1のユーザーでログインする
      sign_in(@user1)
      # 編集ボタンの存在するページに遷移できない
      reject_user(@manual2)
    end
  end
end

RSpec.describe '手順削除', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @manual1 = FactoryBot.create(:manual, user_id: @user1.id)
    @procedure1 = FactoryBot.create(:procedure, user_id: @user1.id, manual_id: @manual1.id)
    @user2 = FactoryBot.create(:user)
    @manual2 = FactoryBot.create(:manual, user_id: @user2.id)
    @procedure2 = FactoryBot.create(:procedure, user_id: @user2.id, manual_id: @manual2.id)
  end

  context '手順削除ができるとき' do
    it '作成者は手順を削除できる' do
      # procedure1のユーザーでログインする
      sign_in(@user1)
      # マニュアル詳細ページに遷移するまで
      move_show(@manual1)
      # 削除ボタンが存在する
      expect(page).to have_link('削除', href: manual_procedure_path(@manual1, @procedure1))
      # 削除ボタンをクリックすると、Manualモデルのカウントが1減少する
      find_link('削除', href: manual_procedure_path(@manual1, @procedure1)).click
      expect {
        expect(page.accept_confirm).to eq('本当に削除しますか？')
        sleep 1
      }.to change { Procedure.count }.by(-1)
      # マニュアル詳細ページに遷移する
      expect(current_path).to eq(manual_path(@manual1))
      # procedure1の情報が存在しない
      check_no_procedure(@procedure1.title, @procedure1.description)
    end
  end

  context '手順削除ができないとき' do
    it '自分が作成した手順以外は削除できない' do
      # procedure1のユーザーでログインする
      sign_in(@user1)
      # 編集ボタンの存在するページに遷移できない
      reject_user(@manual2)
    end
  end
end
