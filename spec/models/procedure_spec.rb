require 'rails_helper'

RSpec.describe Procedure, type: :model do
  before do
    @procedure = FactoryBot.build(:procedure)
  end

  describe 'マニュアル手順新規作成' do
    context 'マニュアル手順情報を保存できるとき' do
      it 'title, image, descriptionが存在すれば保存できる' do
        expect(@procedure).to be_valid
      end
      it 'imageが空でも保存できる' do
        @procedure.image = nil
        expect(@procedure).to be_valid
      end
      it 'descriptionが空でも保存できる' do
        @procedure.description = nil
        expect(@procedure).to be_valid
      end
    end

    context 'マニュアル手順情報を保存できないとき' do
      it 'titleが空だと保存できない' do
        @procedure.title = nil
        @procedure.valid?
        expect(@procedure.errors.full_messages).to include("タイトルを入力してください")
      end
      it 'manualが紐付いていないと保存できない' do
        @procedure.manual = nil
        @procedure.valid?
        expect(@procedure.errors.full_messages).to include('Manualを入力してください')
      end
      it 'userが紐付いていないと保存できない' do
        @procedure.user = nil
        @procedure.valid?
        expect(@procedure.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
