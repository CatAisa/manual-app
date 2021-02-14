require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context 'ユーザー情報を保存できるとき' do
      it 'nickname, email, password, password_confirmationが存在すれば保存できる' do
        expect(@user).to be_valid
      end
      it 'nicknameが半角英数10文字以内ならば保存できる' do
        @user.nickname = 'abcde12345'
        expect(@user).to be_valid
      end
      it 'passwordが半角英字と半角数字の両方を含む8文字以上ならば保存できる' do
        password = 'abcd1234'
        @user.password = password
        @user.password_confirmation = @user.password
      end
    end

    context 'ユーザー情報を保存できないとき' do
      it 'nicknameが空だと保存できない' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('ニックネームを入力してください')
      end
      it 'nicknameが半角英数以外だと保存できない' do
        @user.nickname = 'さとう'
        @user.valid?
        expect(@user.errors.full_messages).to include('ニックネームは半角英数10文字以内で入力してください')
      end
      it 'nicknameが11文字以上だと保存できない' do
        @user.nickname = 'abcde123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('ニックネームは10文字以内で入力してください')
      end
      it 'emailが空だと保存できない' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールを入力してください')
      end
      it 'emailが「@」を含まないと保存できない' do
        @user.email = 'test123'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it 'emailが既に保存されたものと同じだと保存できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'passwordが空だと保存できない' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを入力してください')
      end
      it 'passwordが7文字以下だと保存できない' do
        password = @user.password = 'abc1234'
        @user.password_confirmation = password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは8文字以上で入力してください')
      end
      it 'passwordが半角英数以外だと保存できない' do
        password = 'ab123１２３'
        @user.password = password
        @user.password_confirmation = password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英字と半角数字の両方を含んでください')
      end
      it 'passwordが英字と数字両方を含まないと保存できない' do
        password = '12345678'
        @user.password = password
        @user.password_confirmation = password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英字と半角数字の両方を含んでください')
      end
      it 'passwordとpassword_confirmationが一致していないと保存できない' do
        @user.password_confirmation = @user.password + 'abc123'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end
    end
  end
end
