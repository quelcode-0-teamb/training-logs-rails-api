require 'rails_helper'

RSpec.describe 'measures', type: :request do
  let(:user) { create(:user) }
  let(:user_id) { user.id }
  let(:measure) { create(:measure, user_id: user.id) }
  let(:measure_id) { measure.id }
  let(:options) { { HTTP_AUTHORIZATION: "Bearer #{user.token}" } }
  let(:params) do
    { "measure_params": {
      "body_weight": 1,
      "body_fat": 1,
      "calorie": 1,
      "neck": 1,
      "shoulder": 1,
      "chest": 1,
      "left_biceps": 1,
      "right_biceps": 1,
      "left_forearm": 1,
      "right_forearm": 1,
      "upper_abdomen": 1,
      "lower_abdomen": 1,
      "waist": 1,
      "hips": 1,
      "left_thigh": 1,
      "right_thigh": 1,
      "left_calf": 1,
      "right_calf": 1,
      "date": '2012/2/2'
    } }
  end
  describe 'POST /measures' do
    subject { post '/measures', headers: options, params: params }
    it { is_expected.to eq 201 }
    it { expect { subject }.to change(Measure, :count).by(+1) }
  end

  describe 'DELETE /measure/:measure_id' do
    subject { delete "/measures/#{measure.id}", headers: options }
    before { measure }
    it { is_expected.to eq 204 }
    it { expect { subject }.to change(Measure, :count).by(-1) }
  end

  describe 'PUT /measure/:measure_id' do
    subject { put "/measures/#{measure.id}", headers: options, params: params }
    let(:res_keys) { %w[body_weight body_fat body_fat] }
    it { is_expected.to eq 200 }
  end

  describe 'GET /users/:user_id/measures_index' do
    subject { get "/users/#{user.id}/measures_index", headers: options }
    it { is_expected.to eq 200 }
  end
end
