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
  context 'create可能' do
    it 'user_id,exercise_id,dateがある場合' do
      expect(score).to be_valid
    end
  end
  context 'create不可能' do
    it 'user_idが無い場合' do
      example_score = build(:score, user_id: nil, exercise_id: exercise.id)
      expect(example_score).to_not be_valid
    end
    it 'exercise_idが無い場合' do
      example_score = build(:score, user_id: user.id, exercise_id: nil)
      expect(example_score).to_not be_valid
    end
    describe 'date' do
      it '無い場合' do
        example_score = build(:score, user_id: user.id, exercise_id: exercise.id, date: nil)
        expect(example_score).to_not be_valid
      end
      it '未来の場合' do
        future = Time.zone.today + 1
        example_score = build(:score, user_id: user.id, exercise_id: exercise.id, date: future)
        expect(example_score).to_not be_valid
      end
      it '西暦が2000年、以下の場合' do
        example_score = build(:score, user_id: user.id, exercise_id: exercise.id, date: '1999/12/31')
        expect(example_score).to_not be_valid
      end
    end
  end
end
