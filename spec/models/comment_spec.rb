require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe 'コメント新規作成' do
    context 'コメント情報を保存できるとき' do
      it "content, user_id, manual_id, procedure_idが存在すれば保存できる" do
        expect(@comment).to be_valid
      end
    end

    context 'コメント情報を保存できないとき' do
      it "contentが空だと保存できない" do
        @comment.content = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Content translation missing: ja.activerecord.errors.models.comment.attributes.content.blank")
      end
      it "Userが紐付いていないと保存できない" do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("User translation missing: ja.activerecord.errors.models.comment.attributes.user.required")
      end
      it "Manualが紐付いていないと保存できない" do
        @comment.manual = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Manual translation missing: ja.activerecord.errors.models.comment.attributes.manual.required")
      end
      it "Procedureが紐付いていないと保存できない" do
        @comment.procedure = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Procedure translation missing: ja.activerecord.errors.models.comment.attributes.procedure.required")
      end
    end
  end
end
