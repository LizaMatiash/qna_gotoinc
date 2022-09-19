class User < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :votes, dependent: :destroy
  # validates :email, :password, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
