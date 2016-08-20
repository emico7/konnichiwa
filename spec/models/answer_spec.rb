require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:topic) { create(:topic) }
  let(:question) { create(:question) }
  let(:answer) { create(:answer) }

  it { is_expected.to belong_to(:question) }

  describe "attributes" do
    it "has body attribute" do
     expect(answer).to have_attributes(body: answer.body)
    end
  end
end
