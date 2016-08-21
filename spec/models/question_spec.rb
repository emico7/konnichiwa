require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:user) { create(:user) }
  let(:topic) { create(:topic) }
  let(:question) { create(:question, user: user) }


  it { is_expected.to belong_to(:topic) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:topic) }

  it { is_expected.to validate_length_of(:title).is_at_least(5) }
  it { is_expected.to validate_length_of(:body).is_at_least(10) }

  describe "attributes" do
    it "has a title, body, and user attribute" do
     expect(question).to have_attributes(title: question.title, body: question.body, user: user)
    end
  end
end
