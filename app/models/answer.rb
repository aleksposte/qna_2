class Answer < ApplicationRecord
  belongs_to :question, foreign_key: 'question_id'
  belongs_to :user
  validates :body, presence: true

  default_scope { order('best_answer DESC') }

  def set_best_answer
    Answer.transaction do
      self.question.answers.update_all(best_answer: false)
      self.update!(best_answer: true)
    end
  end

end
