class Question < ApplicationRecord
  belongs_to :topic
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :votes, dependent: :destroy

  default_scope { order('created_at DESC') }

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 10 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true
end
