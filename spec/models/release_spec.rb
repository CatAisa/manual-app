require 'rails_helper'

RSpec.describe Release, type: :model do
  before do
    @release = FactoryBot.build(:release)
  end

  describe '一般公開の設定' do
    context '一般公開が設定できるとき' do
      it 'user_id, manual_idが存在すれば設定できる' do
        expect(@release).to be_valid
      end
    end

    context '一般公開が設定できないとき' do
      it 'userが紐付いていないと設定できない' do
        @release.user = nil
        @release.valid?
        expect(@release.errors.full_messages).to include('Userを入力してください')
      end
      it 'manualが紐付いていないと設定できない' do
        @release.manual = nil
        @release.valid?
        expect(@release.errors.full_messages).to include('Manualを入力してください')
      end
    end
  end
end
