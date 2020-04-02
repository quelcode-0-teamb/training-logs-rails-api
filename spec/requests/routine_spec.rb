require 'rails_helper'

RSpec.describe 'routine', type: :request do
  let(:user) { create(:user) }
  let(:routine) { create(:routine, user_id: user.id) }
  let(:options) { { HTTP_AUTHORIZATION: "Bearer #{user.token}" } }
  let(:params) do
    { "routine_params": {
      "name": 'example'
    } }
  end

  describe 'POST /routines' do
    subject { post '/routines', headers: options, params: params }
    it { is_expected.to eq 201 }
    it { expect { subject }.to change(Routine, :count).by(+1) }
  end

  describe 'DELETE /routines/:routines_id' do
    subject { delete "/routines/#{routine.id}", headers: options }
    before { routine }
    it { is_expected.to eq 204 }
    it { expect { subject }.to change(Routine, :count).by(-1) }
  end

  describe 'PUT /routines/:routines_id' do
    subject { put "/routines/#{routine.id}", headers: options, params: params }
    it { is_expected.to eq 200 }
  end
  describe 'GET /users/:id/routines' do
    subject { get "/users/#{user.id}/routines", headers: options }
    it { is_expected.to eq 200 }
  end

  describe 'GET /routines/:routine_id' do
    subject { get "/routines/#{routine.id}", headers: options }
    it { is_expected.to eq 200 }
  end
end
