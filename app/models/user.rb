class User < ApplicationRecord
  validates :first_name, :last_name, :city, presence: true, on: :update
  has_many :events, dependent: :destroy
  has_many :swipes, dependent: :destroy
  has_attachment :photo
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
