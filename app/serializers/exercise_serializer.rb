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
class ExerciseSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :category,
             :user_id,
             :created_at,
             :updated_at
end
