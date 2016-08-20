require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:topic) { create(:topic) }
  let(:question) { create(:question) }

  it { is_expected.to belong_to(:topic) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:topic) }

  it { is_expected.to validate_length_of(:title).is_at_least(5) }
  it { is_expected.to validate_length_of(:body).is_at_least(10) }

  describe "attributes" do
    it "has title and body attributes" do
     expect(question).to have_attributes(title: question.title, body: question.body)
    end
  end
end
