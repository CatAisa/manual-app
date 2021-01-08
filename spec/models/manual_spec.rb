require 'rails_helper'

RSpec.describe Manual, type: :model do
  before do
    @manual = FactoryBot.build(:manual)  
  end

  describe 'マニュアル新規作成' do
    context 'マニュアル情報を保存できるとき' do
      it "title, category_id, user_idが存在すれば保存できる" do
        expect(@manual).to be_valid
      end
      it "imageが空でも保存できる" do
        @manual.image = nil
        expect(@manual).to be_valid
      end
      it "descriptionが空でも保存できる" do
        @manual.description = nil
        expect(@manual).to be_valid
      end
    end

    context 'マニュアル情報を保存できないとき' do
      it "titleが空だと保存できない" do
        @manual.title = nil
        @manual.valid?
        expect(@manual.errors.full_messages).to include("Title can't be blank")
      end
      it "category_idが空だと保存できない" do
        @manual.category_id = nil
        @manual.valid?
        expect(@manual.errors.full_messages).to include("Category can't be blank")
      end
      it "category_idの値が0だと保存できない" do
        @manual.category_id = 0
        @manual.valid?
        expect(@manual.errors.full_messages).to include("Category is invalid. Select status")
      end
      it "Userが紐づいていないと保存できない" do
        @manual.user = nil
        @manual.valid?
        expect(@manual.errors.full_messages).to include("User must exist")
      end
    end
  end
end
