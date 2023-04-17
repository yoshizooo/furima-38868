require 'rails_helper'

RSpec.describe PurchaseHistoryShoppingAddress, type: :model do
  describe '商品の購入' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @purchase_history_shopping_address = FactoryBot.build(:purchase_history_shopping_address, user_id: user.id, item_id: item.id)
    end

    context '購入に成功' do
      it '全ての値が正しく入力できていれば保存できる' do
        expect(@purchase_history_shopping_address).to be_valid
      end
      it '建物名がなくても購入できる' do
        @purchase_history_shopping_address.building_name = ''
        expect(@purchase_history_shopping_address).to be_valid
      end
    end

    context '購入に失敗' do
      it 'tokenが空だと購入できない' do
        @purchase_history_shopping_address.token = nil
        @purchase_history_shopping_address.valid?
        expect(@purchase_history_shopping_address.errors.full_messages).to include("Token can't be blank")
      end
      it '郵便番号が空だと購入できない' do
        @purchase_history_shopping_address.post_code = ''
        @purchase_history_shopping_address.valid?
        expect(@purchase_history_shopping_address.errors.full_messages).to include("Post code can't be blank")
      end
      it '郵便番号は、「3桁ハイフン4桁」のみ保存可能' do
        @purchase_history_shopping_address.post_code ='1234-123'
        @purchase_history_shopping_address.valid?
        expect(@purchase_history_shopping_address.errors.full_messages).to include("Post code is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it '郵便番号は、半角文字列のみ保存可能' do
        @purchase_history_shopping_address.post_code ='１２３-１２３４'
        @purchase_history_shopping_address.valid?
        expect(@purchase_history_shopping_address.errors.full_messages).to include("Post code is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it '都道府県で---を選択すると購入できない' do
        @purchase_history_shopping_address.prefecture_id = 1
        @purchase_history_shopping_address.valid?
        expect(@purchase_history_shopping_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が空だと購入できない' do
        @purchase_history_shopping_address.municipalities = ''
        @purchase_history_shopping_address.valid?
        expect(@purchase_history_shopping_address.errors.full_messages).to include("Municipalities can't be blank")
      end
      it '番地が空だと購入できない' do
        @purchase_history_shopping_address.address = ''
        @purchase_history_shopping_address.valid?
        expect(@purchase_history_shopping_address.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号が空だと購入できない' do
        @purchase_history_shopping_address.telephone_number =''
        @purchase_history_shopping_address.valid?
        expect(@purchase_history_shopping_address.errors.full_messages).to include("Telephone number can't be blank")
      end
      it '電話番号は、9桁以下は保存できない' do
        @purchase_history_shopping_address.telephone_number ='123456789'
        @purchase_history_shopping_address.valid?
        expect(@purchase_history_shopping_address.errors.full_messages).to include("Telephone number Phone number is invalid. Input only number",
          "Telephone number is too short (minimum is 10 characters)")
      end
      it '電話番号は、12桁以上は保存できない' do
        @purchase_history_shopping_address.telephone_number ='123456789012'
        @purchase_history_shopping_address.valid?
        expect(@purchase_history_shopping_address.errors.full_messages).to include("Telephone number Phone number is invalid. Input only number",
          "Telephone number is too long (maximum is 11 characters)")
        end
      it '電話番号は、半角数値のみ保存可能なこと' do
        @purchase_history_shopping_address.telephone_number ='１２３４５６７８９１'
        @purchase_history_shopping_address.valid?
        expect(@purchase_history_shopping_address.errors.full_messages).to include("Telephone number Phone number is invalid. Input only number")
      end
    end
  end
end
