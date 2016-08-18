require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question) }

  describe "GET #index" do

    before do
      sign_in user
    end

    it "returns http success" do

      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns [question] to @questions" do
      get :index
      expect(assigns(:questions)).to eq([question])
    end
  end

  # describe "GET #show" do
  #   it "returns http success" do
  #     get :show
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #

  describe "GET new" do

    before do
      sign_in user
    end

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

    before do
      sign_in user
    end

    it "increases the number of Question by 1" do
      expect{post :create, params: { question: { title: question.title, body: question.body } } }.to change(Question,:count).by(1)
    end


    it "assigns the new question to @question" do
      post :create, params: { question: { title: question.title, body: question.body } }
      expect(assigns(:question)).to eq Question.last
    end


    it "redirects to the question post" do
      post :create, params: { question: { title: question.title, body: question.body } }
      expect(response).to redirect_to Question.last
    end
  end

  describe "GET edit" do

    before do
      sign_in user
    end

     it "returns http success" do
       get :edit, {id: question.id}
       expect(response).to have_http_status(:success)
     end

     it "renders the #edit view" do
       get :edit, {id: question.id}
       expect(response).to render_template :edit
     end

     it "assigns question to be updated to @question" do
       get :edit, {id: question.id}

       question_instance = assigns(:question)

       expect(question_instance.id).to eq question.id
       expect(question_instance.title).to eq question.title
       expect(question_instance.body).to eq question.body
     end
  end

end
