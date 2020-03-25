require 'rails_helper'

RSpec.describe 'exercises', type: :request do
  let(:user) { create(:user) }
  let(:user_id) { user.id }
  let(:exercise) { create(:exercise, user_id: user.id) }
  let(:exercise_id) { exercise.id }
  let(:options) { { HTTP_AUTHORIZATION: "Bearer #{user.token}" } }
  let(:params) do
    { "exercise_params": {
      "name": 'edit_exercise',
      "category": 'バーベル'
    } }
  end
  describe '/exercises POST' do
    subject { post '/exercises', headers: options, params: params }
    let(:res_body) do
      subject
      JSON.parse(response.body)
    end
    it { is_expected.to eq 201 }
    it { expect { subject }.to change(Exercise, :count).by(+1) }
  end

  describe '/exercises GET' do
    subject { get '/exercises', headers: options }
    let(:res_body) do
      subject
      JSON.parse(response.bddy)
    end
    it { is_expected.to eq 200 }
  end

  describe '/exercises/exercise_id DELETE' do
    subject { delete "/exercises/#{exercise_id}", headers: options }
    before { exercise }
    let(:res_body) do
      subject
      JSON.parse(response.body)
    end
    it { is_expected.to eq 204 }
    it { expect { subject }.to change(Exercise, :count).by(-1) }
  end

  describe '/exercises/exercise_id PUT' do
    subject { put "/exercises/#{exercise_id}", headers: options, params: params }
    let(:res_body) do
      subject
      JSON.parse(response.body)
    end
    it { is_expected.to eq 200 }
  end
end
