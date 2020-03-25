# == Schema Information
#
# Table name: routines
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_routines_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Routine < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  belongs_to :user
  has_many :routine_exercises, dependent: :destroy
  has_many :exercises, through: :routine_exercises
end
