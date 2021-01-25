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
        expect(@release.errors.full_messages).to include('User translation missing: ja.activerecord.errors.models.release.attributes.user.required')
      end
      it 'manualが紐付いていないと設定できない' do
        @release.manual = nil
        @release.valid?
        expect(@release.errors.full_messages).to include('Manual translation missing: ja.activerecord.errors.models.release.attributes.manual.required')
      end
    end
  end
end
