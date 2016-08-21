class Question < ApplicationRecord
  belongs_to :topic
  belongs_to :user
  has_many :answers, dependent: :destroy

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 10 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true
end
