require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe 'コメント新規作成' do
    context 'コメント情報を保存できるとき' do
      it 'content, user_id, manual_id, procedure_idが存在すれば保存できる' do
        expect(@comment).to be_valid
      end
      it 'contentが200文字以内ならば保存できる' do
        @comment.content = 'あ' * 200
        expect(@comment).to be_valid
      end
    end

    context 'コメント情報を保存できないとき' do
      it 'contentが空だと保存できない' do
        @comment.content = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Contentを入力してください')
      end
      it 'contentが201文字以上だと保存できない' do
        @comment.content = 'あ' * 201
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Contentは200文字以内で入力してください')
      end
      it 'Userが紐付いていないと保存できない' do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Userを入力してください')
      end
      it 'Manualが紐付いていないと保存できない' do
        @comment.manual = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Manualを入力してください')
      end
      it 'Procedureが紐付いていないと保存できない' do
        @comment.procedure = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Procedureを入力してください')
      end
    end
  end
end
