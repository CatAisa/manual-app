require 'rails_helper'

RSpec.describe 'ゲストユーザーログイン', type: :system do
  context 'ゲスト１でログインできるとき' do
    it 'ゲスト１が存在しないとき、ゲスト１を作成してからログインする' do
      guest_login_first('ゲスト１', 'guest1', 1)
    end

    it 'ゲスト１が存在するとき、ゲスト１としてログインする' do
      guest_login_again('ゲスト１', 'guest1', 1)
    end
  end

  context 'ゲスト２でログインできるとき' do
    it 'ゲスト２が存在しないとき、ゲスト２を作成してからログインする' do
      guest_login_first('ゲスト２', 'guest2', 2)
    end

    it 'ゲスト２が存在するとき、ゲスト２としてログインする' do
      guest_login_again('ゲスト２', 'guest2', 2)
    end
  end
end