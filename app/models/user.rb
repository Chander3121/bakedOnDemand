class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :refresh_tokens, dependent: :destroy
  has_many :orders, dependent: :nullify
  has_many :addresses, dependent: :destroy

  validates :phone, presence: true

  enum :role, { customer: 0, admin: 1 }
end
