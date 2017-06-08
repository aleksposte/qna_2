class Answer < ApplicationRecord
  belongs_to :question, foreign_key: 'question_id'
  belongs_to :user
  validates :body, presence: true
end
