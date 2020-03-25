require 'rails_helper'
RSpec.describe 'exercises', type: :request do
  let(:user) { create(:user) }
  let(:exercise) { create(:exercise, user_id: user.id) }
  let(:score) { create(:score, user_id: user.id, exercise_id: exercise.id) }
  let(:options) { { HTTP_AUTHORIZATION: "Bearer #{user.token}" } }
  let(:params) do
    { "score_params": {
      "weight": 10,
      "repetitions": 3,
      "interval_time": 30,
      "rpe": 60,
      "sets": 2,
      "date": '2020/1/10'
    } }
  end
  describe 'POST /exercises/:exercise_id/score' do
    subject { post "/exercises/#{exercise.id}/score", headers: options, params: params }
    it { is_expected.to eq 201 }
    it { expect { subject }.to change(Score, :count).by(+params[:score_params][:sets]) }
  end

  describe 'DELETE /scores/:score_id' do
    subject { delete "/scores/#{score.id}", headers: options }
    before { score }
    it { is_expected.to eq 204 }
    it { expect { subject }.to change(Score, :count).by(-1) }
  end

  describe 'PUT /scores/:score_id' do
    subject { put "/scores/#{score.id}", headers: options, params: params }
    it { is_expected.to eq 200 }
  end

  describe 'GET /users/:user_id/scores' do
    subject { get "/users/#{user.id}/scores", headers: options }
    it { is_expected.to eq 200 }
  end
end
