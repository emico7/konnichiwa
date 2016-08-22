require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user, username: "randomuser", email: "random@email.com") }
  let(:other_user) { create(:user) }
  let(:topic) { create(:topic) }
  let(:question) { create(:question, topic: topic, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }

  context "guest" do
    describe "POST create" do
      it "redirects the user to the sign in view" do
        post :create, params: { question_id: question.id, answer: { body: answer.body } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "DELETE destroy" do
      it "redirects the user to the sign in view" do
        delete :destroy, params: { question_id: question.id, id: answer.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context "member user doing CRUD on a answer they don't own" do
     before do
       sign_in other_user
     end

     describe "POST create" do
       it "increases the number of answers by 1" do
         expect{ post :create, params: { question_id: question.id, answer: { body: answer.body } } }.to change(Answer,:count).by(2)
       end

       it "redirects to the question show view" do
         post :create, params: { question_id: question.id, answer: { body: answer.body } }
         expect(response).to redirect_to [topic, question]
       end
     end

     describe "DELETE destroy" do
       it "redirects the user to the question show view" do
         delete :destroy, params: { question_id: question.id, id: answer.id }
         expect(response).to redirect_to [topic, question]
       end
     end
   end

  context "member user doing CRUD on a answer they own" do

    before do
      sign_in user
    end

    describe "POST create" do
      it "increases the number of answers by 1" do
        expect{ post :create, params: { question_id: question.id, answer: { body: answer.body } } }.to change(Answer,:count).by(2)
      end

      it "redirects to the question show view" do
        post :create, params: { question_id: question.id, answer: { body: answer.body } }
        expect(response).to redirect_to [topic, question]
      end
    end

    describe "DELETE destroy" do
      it "deletes the " do
        delete :destroy, params: { question_id: question.id, id: answer.id }
        count = Answer.where({id: answer.id}).count
        expect(count).to eq 0
      end

      it "redirects to the question show view" do
        delete :destroy, params: { question_id: question.id, id: answer.id }
        expect(response).to redirect_to ([topic, question])
      end
    end
  end

  context "admin user doing CRUD on a answer they don't own" do
    before do
      other_user.admin!
      sign_in other_user
    end

    describe "POST create" do
      it "increases the number of answers by 1" do
        expect{ post :create, params: { question_id: question.id, answer: { body: answer.body } } }.to change(Answer,:count).by(2)
      end

      it "redirects to the question show view" do
        post :create, params: { question_id: question.id, answer: { body: answer.body } }
        expect(response).to redirect_to [topic, question]
      end
    end

    describe "DELETE destroy" do
      it "deletes the " do
        delete :destroy, params: { question_id: question.id, id: answer.id }
        count = Answer.where({id: answer.id}).count
        expect(count).to eq 0
      end

      it "redirects to the question show view" do
        delete :destroy, params: { question_id: question.id, id: answer.id }
        expect(response).to redirect_to ([topic, question])
      end
    end
  end
end
