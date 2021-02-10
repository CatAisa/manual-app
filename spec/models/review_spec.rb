require 'rails_helper'

RSpec.describe Review, type: :model do
  before do
    @review = FactoryBot.build(:review)
  end

  describe 'レビュー新規作成' do
    context 'レビュー情報を保存できるとき' do
      it 'content, user_id, manual_idが存在すれば保存できる' do
        expect(@review).to be_valid
      end
    end

    context 'レビュー情報を保存できないとき' do
      it 'contentが空だと保存できない' do
        @review.content = nil
        @review.valid?
        expect(@review.errors.full_messages).to include('Content translation missing: ja.activerecord.errors.models.review.attributes.content.blank')
      end
      it 'Userが紐付いていないと保存できない' do
        @review.user = nil
        @review.valid?
        expect(@review.errors.full_messages).to include('User translation missing: ja.activerecord.errors.models.review.attributes.user.required')
      end
      it 'Manualが紐付いていないと保存できない' do
        @review.manual = nil
        @review.valid?
        expect(@review.errors.full_messages).to include('Manual translation missing: ja.activerecord.errors.models.review.attributes.manual.required')
      end
    end
  end
end
