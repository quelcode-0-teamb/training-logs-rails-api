class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 16 }, uniqueness: true,
                   format: { with: /\A[a-zA-Z\d]+\z/ } # 英数字のみ
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i } # メール書式フォーマット
  has_secure_token
  has_secure_password

  has_many :measures, dependent: :destroy
  has_many :exercises, dependent: :destroy
  has_many :scores, dependent: :destroy
  # Routine
  has_many :routines, dependent: :destroy
  has_many :routine_exercises, through: :routines
end
