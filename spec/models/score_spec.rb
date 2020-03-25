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
require 'rails_helper'

RSpec.describe Score, type: :model do
  let(:user) { create(:user) }
  let(:exercise) { create(:exercise, user_id: user.id) }
  let(:score) { build(:score, user_id: user.id, exercise_id: exercise.id) }
  describe '#valid score' do
    it 'user_id,exercise_id,dateがある場合' do
      expect(score).to be_valid
    end
    context '#valid id' do
      it 'user_idが無い場合' do
        score.user_id = nil
        expect(score).to_not be_valid
      end
      it 'exercise_idが無い場合' do
        score.exercise_id = nil
        expect(score).to_not be_valid
      end
    end
    context '#valid date' do
      it '無い場合' do
        score.date = nil
        expect(score).to_not be_valid
      end
      it '未来の場合' do
        future = Time.zone.today + 1
        score.date = future
        expect(score).to_not be_valid
      end
      it '西暦が2000年、以下の場合' do
        score.date = '1999/12/31'
        expect(score).to_not be_valid
      end
    end
  end
end
