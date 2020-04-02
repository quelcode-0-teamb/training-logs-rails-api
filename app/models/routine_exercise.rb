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
class RoutineExercise < ApplicationRecord
  belongs_to :exercise
  belongs_to :routine

  def self.add_exercises(set_routine, routine_exercise_params)
    exercise_array = []
    ActiveRecord::Base.transaction do
      # フロント側の負担が多すぎるのでサーバー側でeachを使い処理しました。(アンチパターンだと思うけど。。)
      routine_exercise_params.each do |ary|
        exercise = Exercise.find(ary[:exercise_id])
        routine_exercise = RoutineExercise.new
        routine_exercise.routine_id = set_routine.id
        routine_exercise.exercise_id = exercise.id
        routine_exercise.save!
        exercise_array << routine_exercise
      end
    end
    exercise_array
  end
end
