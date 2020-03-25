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
FactoryBot.define do
  factory :score do
    user_id { nil }
    exercise_id { nil }
    weight { 30.0 }
    repetitions { 4 }
    interval_time { 40 }
    rpe { 9.5 }
    date { '2020/2/2' }
  end
end
