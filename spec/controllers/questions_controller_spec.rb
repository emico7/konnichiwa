require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question) }

  context "guest user" do

    describe "GET show" do
      it "returns http success" do
        get :show, { params: {id: question.id} }
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET new" do
      it "returns http redirect" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context "member user" do
    before do
      sign_in user
    end

    describe "GET index" do

      # before do
      #   sign_in user
      # end

      it "returns http success" do

        get :index
        expect(response).to have_http_status(:success)
      end

      it "assigns [question] to @questions" do
        get :index
        expect(assigns(:questions)).to eq([question])
      end
    end

    # describe "GET show" do
    #   it "returns http success" do
    #     # sign_in user
    #     get :show
    #     expect(response).to have_http_status(:success)
    #   end
    # end


    describe "GET new" do

      # before do
      #   sign_in user
      # end

      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "renders the new view" do
        get :new
        expect(response).to render_template :new
      end


      it "instantiates @question" do
        get :new
        expect(assigns(:question)).not_to be_nil
      end
    end

    describe "POST create" do

      # it "increases the number of Question by 1" do
      #   expect{post :create, params: { question: { title: question.title, body: question.body } } }.to change(Question,:count).by(1)
      # end


      it "assigns the new question to @question" do
        # sign_in user
        post :create, params: { question: { title: question.title, body: question.body } }
        expect(assigns(:question)).to eq Question.last
      end


      it "redirects to the question post" do
        # sign_in user
        post :create, params: { question: { title: question.title, body: question.body } }
        expect(response).to redirect_to Question.last
      end
    end

    describe "GET edit" do

      # before do
      #   sign_in user
      # end

      it "returns http success" do
        get :edit, { params: {id: question.id} }
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit,  { params: {id: question.id} }
        expect(response).to render_template :edit
      end

      it "assigns question to be updated to @question" do
        get :edit,  { params: {id: question.id} }

        question_instance = assigns(:question)

        expect(question_instance.id).to eq question.id
        expect(question_instance.title).to eq question.title
        expect(question_instance.body).to eq question.body
      end
    end

    # describe "PUT update" do
    #
    #   # before do
    #   #   sign_in user
    #   # end
    #
    #   let(:updated_question) { create(:question) }
    #
    #   it "updates question with expected attributes" do
    #     new_title = updated_question.title
    #     new_body = updated_question.body
    #
    #     put :update, id: question.id, params: { question: {title: new_title, body: new_body} }
    #
    #     updated_question = assigns(:question)
    #     expect(updated_question.id).to eq question.id
    #     expect(updated_question.title).to eq new_title
    #     expect(updated_question.body).to eq new_body
    #   end
    #
    #   it "redirects to the updated question" do
    #     new_title = updated_question.title
    #     new_body = updated_question.body
    #
    #     put :update, id: question.id, params: { question: {title: new_title, body: new_body} }
    #     expect(response).to redirect_to question
    #   end
    # end

    describe "DELETE destroy" do

      it "deletes the question" do
        delete :destroy, {id: question.id}
        count = Question.where({id: question.id}).size
        expect(count).to eq 0
      end

      it "redirects to questions index" do
        delete :destroy, {id: question.id}
        expect(response).to redirect_to questions_path
      end
    end
  end
end
