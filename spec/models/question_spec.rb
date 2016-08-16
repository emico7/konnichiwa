require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { create(:question) }


  describe "attributes" do
    it "has title and body attributes" do
     expect(question).to have_attributes(title: question.title, body: question.body)
    end
  end
end
