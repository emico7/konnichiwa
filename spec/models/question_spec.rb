require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:topic) { create(:topic) }
  let(:question) { create(:question) }

  it { is_expected.to belong_to(:topic) }

  describe "attributes" do
    it "has title and body attributes" do
     expect(question).to have_attributes(title: question.title, body: question.body)
    end
  end
end
