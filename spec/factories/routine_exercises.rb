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
FactoryBot.define do
  factory :routine_exercise do
    exercise_id { nil }
    routine_id { nil }
  end
end
