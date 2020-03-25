# == Schema Information
#
# Table name: measures
#
#  id            :bigint           not null, primary key
#  body_fat      :float
#  body_weight   :float
#  calorie       :float
#  chest         :float
#  date          :date
#  hips          :float
#  left_biceps   :float
#  left_calf     :float
#  left_forearm  :float
#  left_thigh    :float
#  lower_abdomen :float
#  neck          :float
#  right_biceps  :float
#  right_calf    :float
#  right_forearm :float
#  right_thigh   :float
#  shoulder      :float
#  upper_abdomen :float
#  waist         :float
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint
#
# Indexes
#
#  index_measures_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Measure, type: :model do
  let(:user) { create(:user) }
  let(:measure) { build(:measure, user_id: user.id) }
  describe '#valid measure' do
    context '#valid user_id' do
      it 'user_id,dateがある場合' do
        expect(measure).to be_valid
      end
      it 'user_idが無い場合' do
        measure.user_id = nil
        expect(measure).to_not be_valid
      end
    end
    context '#valid date' do
      it '無い場合' do
        measure.date = nil
        expect(measure).to_not be_valid
      end
      it '未来の場合' do
        future = Time.zone.today + 1
        measure.date = future
        expect(measure).to_not be_valid
      end
      it '西暦が2000年、以下の場合' do
        measure.date = '1999/12/31'
        expect(measure).to_not be_valid
      end
    end
  end
end
