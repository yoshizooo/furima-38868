require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる' do
      it 'すべての項目があれば登録できる' do
        expect(@user).to be_valid
      end
      it 'emailにて@を含んでいれば登録できる' do
        @user.email = Faker::Internet.free_email
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationが6文字以上かつ英数字混合であれば登録できる' do
        @user.password = Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1)
        @user.password_confirmation = @user.password
        expect(@user).to be_valid
      end
      it 'fist_nameが全角だと登録できる' do
        @user.first_name = 'テスト'
        expect(@user).to be_valid
      end
      it 'last_nameが全角だと登録できる' do
        @user.last_name = 'テスト'
        expect(@user).to be_valid
      end
      it 'fist_name_kanaがカタカナだと登録できる' do
        @user.first_name_kana = 'テスト'
        expect(@user).to be_valid
      end
      it 'last_name_kanaがカタカナだと登録できる' do
        @user.last_name_kana = 'テスト'
        expect(@user).to be_valid
      end
    end
    context '新規登録ができない' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空だと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it 'emailは@を含まないと登録できない' do 
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'passwordが空だと登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下だと登録できない' do
        @user.password ='a1234'
        @user.password_confirmation = 'a1234'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
          
      end
      it 'passwordが129文字以上だと登録できない' do
        @user.password = Faker::Lorem.characters(number: 129, min_alpha: 1, min_numeric: 1)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too long (maximum is 128 characters)")
      end
      it 'passwordは英語のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password  is invalid. Include both letters and numbers")
      end
      it 'passwordは数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password  is invalid. Include both letters and numbers")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'a12345'
        @user.password_confirmation = 'b12345'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'お名前(全角)の苗字が空だと登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'お名前(全角)の名前が空だと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'お名前(全角)は、全角（漢字・ひらがな・カタカナ)で入力しなければ登録できない' do
        @user.last_name = '123'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid. Input full-width characters")
      end
      it 'お名前(全角)の苗字は、全角（漢字・ひらがな・カタカナ)で入力しなければ登録できない' do
        @user.first_name = '123'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid. Input full-width characters")
      end
      it 'お名前カナ(全角)の苗字が空だと登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'お名前カナ(全角)の名前が空だと登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'お名前カナ(全角)は、全角（カタカナ)で入力しなければ登録できない' do
        @user.last_name_kana = 'てすと'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid. Input full-width katakana characters")
      end
      it 'お名前カナ(全角)の苗字は、全角（漢字・ひらがな・カタカナ)で入力しなければ登録できない' do
        @user.first_name_kana = 'てすと'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid. Input full-width katakana characters")
      end
      it '生年月が空だと登録できない' do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
