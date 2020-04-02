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
class RoutineSerializer < ActiveModel::Serializer
  attributes :id,
             :user_id,
             :name,
             :created_at,
             :updated_at
end
