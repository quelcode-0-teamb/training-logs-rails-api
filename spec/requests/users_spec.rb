require 'rails_helper'
require 'pry'

RSpec.describe 'Users', type: :request do
  describe '非ログイン時' do
    context 'GET /' do
      subject { get '/' }
      it { is_expected.to eq 200 }
    end

    context 'POST /sign_up' do
      let(:params) { attributes_for(:user) }
      subject(:sign_up) { post '/sign_up', params: { "sign_up_params": params } }
      let(:res_keys) { %w[name email] }
      let(:res_body) do
        sign_up
        JSON.parse(response.body)
      end
      it { is_expected.to eq 201 }
      it { expect { sign_up }.to change(User, :count).by(+1) }
      it { expect(res_body.length).to eq 8 }
      it 'usersに追加されたデータと送ったデータが一致' do
        db_added_user = User.find(res_body['id'])
        res_keys.each { |key| expect(db_added_user[key]).to eq params[key.intern] }
      end
      it 'レスポンスデータが期待どおり' do
        res_keys.each { |key| expect(res_body[key]).to eq params[key.intern] }
        expect(res_body['token'].length).to eq 24
      end
      it 'usersに追加されたトークンとレスポンスのトークンが一致' do
        db_added_user = User.find(res_body['id'])
        expect(res_body['token']).to eq db_added_user.token
      end
    end

    context 'POST /login' do
      let(:sign_up_params) { attributes_for(:user) }
      let(:user) { User.create(sign_up_params) }
      let(:params) do
        {
          "sign_in_params": {
            "sign_in_text": sign_up_params[:email],
            "password": sign_up_params[:password]
          }
        }
      end
      subject(:login) { post '/sign_in', params: params }
      before { user }
      let(:res_keys) { %w[id name token email] }
      let(:res_body) do
        login
        JSON.parse(response.body)
      end
      it { is_expected.to eq 200 }
      it { expect(res_body.length).to eq 8 }
      it 'usersに追加されたデータとレスポンスデータが一致' do
        res_keys.each { |key| expect(res_body[key]).to eq user[key] }
      end
      context 'paramsが異なる時' do
        it 'wrong email bad response' do
          params[:sign_in_params][:sign_in_text] = 'wrong@example.com'
          expect(login).to eq 404
        end
        it 'wrong password bad response' do
          params[:sign_in_params][:password] = 'wrongpasrsword'
          expect(login).to eq 400
        end
      end
    end
  end

  describe 'ログイン時' do
    describe 'users' do
      let(:user) { create(:user) }
      let(:options) { { HTTP_AUTHORIZATION: "Bearer #{user.token}" } }
      let(:params) do
        {
          "user_update_params": {
            "name": 'updateName',
            "email": 'update@gmail.com',
            "user_private": 'true'
          }
        }
      end
      describe '/users/:id' do
        context 'show' do
          subject(:show_user) do
            get "/users/#{user.id}", headers: options
          end
          let(:res_body) do
            show_user
            JSON.parse(response.body)
          end
          it { is_expected.to eq 200 }
        end
        context 'update' do
          subject(:update_user) do
            put "/users/#{user.id}", headers: options, params: params
          end
          let(:res_body) do
            update_user
            JSON.parse(response.body)
          end
          it { is_expected.to eq 200 }
        end
        context 'delete' do
          subject(:delete_user) do
            delete "/users/#{user.id}", headers: options
          end
          before { user }
          it { is_expected.to eq 204 }
          it { expect { subject }.to change(User, :count).by(-1) }
        end
      end
    end
  end
end
