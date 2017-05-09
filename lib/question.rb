class Question < ActiveRecord::Base
  belongs_to(:surveys)
  has_many(:answers, dependent: :destroy)

  def clear_answers
    answers.each do |answer|
      answer.delete
    end
  end
end
