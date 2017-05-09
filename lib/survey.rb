class Survey < ActiveRecord::Base
  has_many(:questions, dependent: :destroy)
  before_save(:capitalize_each_name)

  def capitalize_each_name
    name_array = name.downcase.split()
    name_array.each do |w|
      w.capitalize!
    end
    self.name = name_array.join(' ')
  end

end
