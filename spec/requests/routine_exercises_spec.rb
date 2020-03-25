require 'rails_helper'

RSpec.describe 'RoutineExercises', type: :request do
  let(:user) { create(:user) }
  let(:exercise) { create(:exercise, user_id: user.id) }
  let(:routine) { create(:routine, user_id: user.id) }
  let(:routine_exercise) { create(:routine_exercise, exercise_id: exercise.id, routine_id: routine.id) }
  let(:options) { { HTTP_AUTHORIZATION: "Bearer #{user.token}" } }
  let(:params) do
    { "routine_exercise_params": [
      { "exercise_id": exercise.id },
      { "exercise_id": exercise.id },
      { "exercise_id": exercise.id }
    ] }
  end
  describe 'POST /routines/routine_id/routine_exercises' do
    subject { post "/routines/#{routine.id}/routine_exercises", headers: options, params: params }
    it { is_expected.to eq 201 }
    it { expect { subject }.to change(RoutineExercise, :count).by(+3) }
  end
  describe 'DELETE /routines/routine_id/routine_exercises/:routine_exercise_id' do
    subject { delete "/routines/#{routine.id}/routine_exercises/#{routine_exercise.id}", headers: options }
    before { routine_exercise }
    it { is_expected.to eq 204 }
    it { expect { subject }.to change(RoutineExercise, :count).by(-1) }
  end
end
