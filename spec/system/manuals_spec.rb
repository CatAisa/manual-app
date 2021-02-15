require 'rails_helper'

RSpec.describe 'マニュアル新規作成', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @manual = FactoryBot.build(:manual)
  end

  context 'マニュアル新規作成ができるとき（画像加工なし）' do
    it '正しい情報を入力すればマニュアルを新規作成できて、マイページに遷移する' do
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
      image_path = Rails.root.join('public/images/test_image.jpg')
      attach_file('manual[image]', image_path, make_visible: true)
      fill_in 'manual_description', with: @manual.description
      # 情報を送信すると、Manualモデルのカウントが1増加する
      expect {
        find('input[name="commit"]').click
      }.to change { Manual.count }.by(1)
      # マイページに遷移する
      expect(current_path).to eq(user_path(@user))
      # マイページに先ほど保存した内容が表示されている
    end
  end

  context 'マニュアル新規作成ができないとき' do
    it '誤った情報を入力するとマニュアルを新規作成できず、入力フォームに戻ってくる' do
      
    end
  end
end
