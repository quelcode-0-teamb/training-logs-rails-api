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
class Measure < ApplicationRecord
  validate :date_presence_check # 記録日の論理チェック ApplicationRecordに定義
  belongs_to :user
  scope :date_desc, -> { order(date: :desc, created_at: :desc) }
end
