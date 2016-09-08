class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :votes, dependent: :destroy

  before_save { self.role ||= :member }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :username,
    :presence => true,
    :uniqueness => {
      :case_sensitive => false
    }

  enum role: [:member, :admin]
end
