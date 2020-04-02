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
FactoryBot.define do
  factory :exercise do
    user_id { nil }
    category { 1 }
    name { 'ベンチプレス' }
  end
end
