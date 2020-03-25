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
  let(:routine_exercise) { build(:routine_exercise, exercise_id: exercise.id, routine_id: routine.id) }
  describe '#valid id' do
    it 'routine_id,exercise_idがある場合' do
      expect(routine_exercise).to be_valid
    end
    it 'routine_idが無い場合' do
      routine_exercise.routine_id = nil
      expect(routine_exercise).to_not be_valid
    end
    it 'exercise_idがない場合' do
      routine_exercise.exercise_id = nil
      expect(routine_exercise).to_not be_valid
    end
  end
end
