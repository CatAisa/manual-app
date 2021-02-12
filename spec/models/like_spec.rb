require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    @like = FactoryBot.build(:like)
  end

  describe 'お気に入り登録' do
    context 'お気に入り登録できるとき' do
      it 'user_id, manual_idが存在すれば設定できる' do
        expect(@like).to be_valid
      end
    end

    context 'お気に入り登録できないとき' do
      it 'userが紐付いていないと設定できない' do
        @like.user = nil
        @like.valid?
        expect(@like.errors.full_messages).to include('Userを入力してください')
      end
      it 'manualが紐付いていないと設定できない' do
        @like.manual = nil
        @like.valid?
        expect(@like.errors.full_messages).to include('Manualを入力してください')
      end
    end
  end
end
