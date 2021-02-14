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
      it 'contentが200文字以内ならば保存できる' do
        @review.content = "あ" * 200
        expect(@review).to be_valid
      end
    end

    context 'レビュー情報を保存できないとき' do
      it 'contentが空だと保存できない' do
        @review.content = nil
        @review.valid?
        expect(@review.errors.full_messages).to include('Contentを入力してください')
      end
      it 'contentが201文字以上だと保存できない' do
        @review.content = "あ" * 201
        @review.valid?
        expect(@review.errors.full_messages).to include('Contentは200文字以内で入力してください')
      end
      it 'Userが紐付いていないと保存できない' do
        @review.user = nil
        @review.valid?
        expect(@review.errors.full_messages).to include('Userを入力してください')
      end
      it 'Manualが紐付いていないと保存できない' do
        @review.manual = nil
        @review.valid?
        expect(@review.errors.full_messages).to include('Manualを入力してください')
      end
    end
  end
end
