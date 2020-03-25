# == Schema Information
#
# Table name: exercises
#
#  id         :bigint           not null, primary key
#  category   :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_exercises_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Exercise, type: :model do
  let(:user) { create(:user) }
  let(:exercise) { build(:exercise, user_id: user.id) }
  describe '#valid exercise' do
    it 'user_id,name,categoryがある場合' do
      expect(exercise).to be_valid
    end
    it 'user_idが無い場合' do
      exercise.user_id = nil
      expect(exercise).to_not be_valid
    end
    it 'categoryが無い場合' do
      exercise.category = nil
      expect(exercise).to_not be_valid
    end
    it 'nameが無い場合' do
      exercise.name = nil
      expect(exercise).to_not be_valid
    end
  end
end
