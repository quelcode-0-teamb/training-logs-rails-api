# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string
#  name            :string
#  password_digest :string
#  token           :string
#  user_private    :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#  index_users_on_name   (name) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  describe '#valid user' do
    it 'name、email、password,password_confirmationがある場合、有効である' do
      expect(user).to be_valid
    end
    describe '#valid name' do
      it 'ない場合、無効である' do
        user.name = nil
        expect(user).to_not be_valid
      end
      it '16文字以下の場合、有効である' do
        user.name = 'a' * 16
        expect(user).to be_valid
      end
      it '16文字以上の場合、無効である' do
        user.name = 'a' * 17
        expect(user).to_not be_valid
      end
      it 'nameが英数字以外の場合、無効である' do
        user.name = 'あ'
        expect(user).to_not be_valid
      end
    end
    describe '#valid email' do
      it 'ない場合、無効である' do
        user.email = nil
        expect(user).to_not be_valid
      end
      it '文字数が255以下の場合、有効である' do
        user.email = "#{'a' * (255 - 12)}@example.com"
        expect(user).to be_valid
      end
      it '文字数が255以上の場合、無効である' do
        user.email = "#{'a' * 256}@example.com"
        expect(user).to_not be_valid
      end
      it '英数字@英数字.英数字が有効である' do
        user.email = 'user1@email.com'
        expect(user).to be_valid
      end
      it '英数字以外@英数字.英数字が無効である' do
        user.email = 'ユーザー@email.com'
        expect(user).to_not be_valid
      end
      it '英数字@英数字以外.英数字が無効である' do
        user.email = 'user@eメール.com'
        expect(user).to_not be_valid
      end
      it '英数字@英数字.英数字が無効である' do
        user.email = 'user@email.コム'
        expect(user).to_not be_valid
      end
      it '@が含まれていないと無効である' do
        user.email = 'useremail.com'
        expect(user).to_not be_valid
      end
      it '.が含まれていないと無効である' do
        user.email = 'user@emailcom'
        expect(user).to_not be_valid
      end
    end
    describe '#valid password' do
      it 'ない場合、無効である' do
        user.password = nil
        user.password_confirmation = nil
        expect(user).to_not be_valid
      end
      it 'passwordとpassword_confirmationが一致しない場合、無効である' do
        user.password = '1'
        user.password_confirmation = '2'
        expect(user).to_not be_valid
      end
    end
  end
end
