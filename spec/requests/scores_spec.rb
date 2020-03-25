require 'rails_helper'
RSpec.describe 'exercises', type: :request do
  let(:user) { create(:user) }
  let(:user_id) { user.id }
  let(:exercise) { create(:exercise, user_id: user.id) }
  let(:exercise_id) { exercise.id }
  let(:score) { create(:score, user_id: user.id, exercise_id: exercise.id) }
  let(:score_id) { score.id }
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
  describe '/exercises/:exercise_id/score POST' do
    subject { post "/exercises/#{exercise_id}/score", headers: options, params: params }
    let(:res_body) do
      subject
      JSON.parse(response.body)
    end
    it { is_expected.to eq 201 }
    it { expect { subject }.to change(Score, :count).by(+params[:score_params][:sets]) }
  end

  describe '/scores/:score_id DELETE' do
    subject { delete "/scores/#{score_id}", headers: options }
    before { score }
    it { is_expected.to eq 204 }
    it { expect { subject }.to change(Score, :count).by(-1) }
  end

  describe '/scores/:score_id PUT' do
    subject { put "/scores/#{score_id}", headers: options, params: params }
    let(:res_body) do
      subject
      JSON.parse(response.body)
    end
    it { is_expected.to eq 200 }
  end

  describe '/users/:user_id/scores_index GET' do
    subject { get "/users/#{user_id}/scores_index", headers: options }
    it { is_expected.to eq 200 }
  end
end
