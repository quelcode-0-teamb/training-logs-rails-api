require 'rails_helper'

RSpec.describe 'exercises', type: :request do
  let(:user) { create(:user) }
  let(:exercise) { create(:exercise, user_id: user.id) }
  let(:options) { { HTTP_AUTHORIZATION: "Bearer #{user.token}" } }
  let(:params) do
    { "exercise_params": {
      "name": 'edit_exercise',
      "category": 'バーベル'
    } }
  end
  describe 'POST /exercises' do
    subject { post '/exercises', headers: options, params: params }
    it { is_expected.to eq 201 }
    it { expect { subject }.to change(Exercise, :count).by(+1) }
  end

  describe 'GET /exercises' do
    subject { get '/exercises', headers: options }
    it { is_expected.to eq 200 }
  end

  describe 'DELETE /exercises/exercise_id' do
    subject { delete "/exercises/#{exercise.id}", headers: options }
    before { exercise }
    it { is_expected.to eq 204 }
    it { expect { subject }.to change(Exercise, :count).by(-1) }
  end

  describe 'PUT /exercises/exercise_id' do
    subject { put "/exercises/#{exercise.id}", headers: options, params: params }
    it { is_expected.to eq 200 }
  end
end
