class Answers < ActiveRecord::Base
  belongs_to(:questions)
end
