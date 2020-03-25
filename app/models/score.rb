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
class Score < ApplicationRecord
  validate :date_presence_check # 記録日の論理チェック　ApplicationRecordに定義
  belongs_to :user
  belongs_to :exercise
  default_scope -> { order(date: :desc) }

  def self.add_exercise_to_scores(score_params, set_num, exercise_id, user)
    # フロント側の負担が多すぎるのでサーバー側でeachを使い処理しました。(アンチパターンだと思うけど。。)
    check_sets(set_num)
    ActiveRecord::Base.transaction do
      (1..set_num).each do
        score = user.scores.new(score_params)
        score.exercise = Exercise.find(exercise_id)
        score.save!
      end
    end
  end

  def self.add_routine_scores(routine_score_params, user)
    ActiveRecord::Base.transaction do
      # フロント側の負担が多すぎるのでサーバー側でeachを使い処理しました。(アンチパターンだと思うけど。。)
      routine_score_params.each do |ary|
        # ネストのpermitがうまくいかなかったので、permit!で強行突破しました。
        ary.permit!
        set_num = ary[:sets].to_i
        check_sets(set_num)
        (1..set_num).each do
          score = Score.new(ary[:score_params])
          score.user = user
          score.exercise = Exercise.find(ary[:score_params][:exercise_id])
          score.save!
        end
      end
    end
  end

  # 記録セット数の確認
  def self.check_sets(num)
    return unless num >= 20

    raise ActionController::BadRequest, 'setsは1以上20以下に設定して下さい。'
  end
end
