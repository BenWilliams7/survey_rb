require 'spec_helper'

describe(Survey) do
  describe('#capitalize_each_name') do
    it('will capitalize each word in the name') do
      survey1 = Survey.new({:name => 'test survey'})
      survey1.capitalize_each_name
      expect(survey1.name).to eq ('Test Survey')
    end
  end
end
