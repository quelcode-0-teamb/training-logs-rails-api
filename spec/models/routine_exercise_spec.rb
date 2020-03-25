# == Schema Information
#
# Table name: routine_exercises
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  exercise_id :bigint
#  routine_id  :bigint
#
# Indexes
#
#  index_routine_exercises_on_exercise_id  (exercise_id)
#  index_routine_exercises_on_routine_id   (routine_id)
#
# Foreign Keys
#
#  fk_rails_...  (exercise_id => exercises.id)
#  fk_rails_...  (routine_id => routines.id)
#
require 'rails_helper'

RSpec.describe RoutineExercise, type: :model do
  let(:user) { create(:user) }
  let(:routine) { create(:routine, user_id: user.id) }
  let(:exercise) { create(:exercise, user_id: user.id) }
  context 'create可能' do
    it 'routine_id,exercise_idがある場合' do
      example_r_e = build(:routine_exercise, routine_id: routine.id, exercise_id: exercise.id)
      expect(example_r_e).to be_valid
    end
  end
  context 'create不可' do
    it 'routine_idが無い場合' do
      example_r_e = build(:routine_exercise, routine_id: nil, exercise_id: exercise.id)
      expect(example_r_e).to_not be_valid
    end
    it 'exercise_idがない場合' do
      example_r_e = build(:routine_exercise, routine_id: routine.id, exercise_id: nil)
      expect(example_r_e).to_not be_valid
    end
  end
end
