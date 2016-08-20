require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:topic) { create(:topic) }

  it { is_expected.to have_many(:questions) }


  describe "attributes" do
     it "has name, description, and public attributes" do
       expect(topic).to have_attributes(name: topic.name, description: topic.description, public: true)
     end


     it "is public by default" do
       expect(topic.public).to be(true)
     end
   end
end
