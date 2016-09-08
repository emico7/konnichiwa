require 'rails_helper'

RSpec.describe Vote, type: :model do
  let(:topic) { create(:topic) }
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:vote) { create(:vote, question: question, user: user) }


  it { is_expected.to belong_to(:question) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:value) }
  it { is_expected.to validate_inclusion_of(:value).in_array([-1, 1]) }
end
