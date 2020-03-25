# == Schema Information
#
# Table name: scores
#
#  id            :bigint           not null, primary key
#  date          :date
#  interval_time :integer
#  repetitions   :integer
#  rpe           :float
#  weight        :float
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  exercise_id   :bigint
#  user_id       :bigint
#
# Indexes
#
#  index_scores_on_exercise_id  (exercise_id)
#  index_scores_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (exercise_id => exercises.id)
#  fk_rails_...  (user_id => users.id)
#
class ScoreSerializer < ActiveModel::Serializer
  attributes :id,
             :weight,
             :repetitions,
             :interval_time,
             :rpe,
             :date,
             :exercise_id,
             :user_id,
             :created_at,
             :updated_at
end
