class User < ApplicationRecord
  validates :first_name, :last_name, :city, presence: true, on: :update
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
