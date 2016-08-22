require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:topic) { create(:topic) }
  let(:question) { create(:question, topic: topic, user: user) }

  context "guest user" do

    describe "GET show" do
      it "returns http success" do
        get :show, params: { topic_id: topic.id, id: question.id }
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET new" do
      it "returns http redirect" do
        get :new, params: { topic_id: topic.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context "member user doing CRUD on a post they don't own" do
    before do
      sign_in other_user
    end

    # describe "GET index" do
    #
    #   before do
    #     sign_in user
    #   end
    #
    #   it "returns http success" do
    #     get :index
    #     expect(response).to have_http_status(:success)
    #   end
    #
    #   it "assigns [question] to @questions" do
    #     get :index
    #     expect(assigns(:questions)).to eq([question])
    #   end
    # end

    describe "GET show" do
      it "returns http success" do
        get :show, params: { topic_id: topic.id, id: question.id }
        expect(response).to have_http_status(:success)
      end
    end


    describe "GET new" do

      it "returns http success" do
        topic.reload
        get :new, params: { topic_id: topic.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the new view" do
        topic.reload
        get :new, params: { topic_id: topic.id }
        expect(response).to render_template :new
      end


      it "instantiates @question" do
        topic.reload
        get :new, params: { topic_id: topic.id }
        expect(assigns(:question)).not_to be_nil
      end
    end

    describe "POST create" do

      # it "increases the number of Question by 1" do
      #   topic.reload
      #   expect{post :create, params: {topic_id: topic.id, question: { title: question.title, body: question.body } } }.to change(Question,:count).by(1)
      # end


      # it "assigns the new question to @question" do
      #   topic.reload
      #   post :create, params: { topic_id: topic.id, question: { title: question.title, body: question.body } }
      #   expect(assigns(:question)).to eq Question.last
      # end
      #
      #
      # it "redirects to the question post" do
      #   post :create, params: { topic_id: topic.id, question: { title: question.title, body: question.body } }
      #   expect(response).to redirect_to [topic, Question.last]
      # end
    end

    describe "GET edit" do

      it "returns http redirect" do
        get :edit, { params: { topic_id: topic.id, id: question.id} }
        expect(response).to redirect_to([topic, question])
      end
    end

    describe "PUT update" do

      it "returns http redirects" do
        new_title = "Updated title"
        new_body = "This is an updated body."

        put :update, params: { topic_id: topic.id, id: question.id, question: {title: new_title, body: new_body} }
        expect(response).to redirect_to([topic, question])
      end
    end

    describe "DELETE destroy" do

      it "returns http redirect" do
        delete :destroy, params: { topic_id: topic.id, id: question.id }
        expect(response).to redirect_to([topic, question])
      end
    end
  end

  context "member user doing CRUD on a post they own" do
    before do
      sign_in user
    end

    # describe "GET index" do
    #
    #   before do
    #     sign_in user
    #   end
    #
    #   it "returns http success" do
    #     get :index
    #     expect(response).to have_http_status(:success)
    #   end
    #
    #   it "assigns [question] to @questions" do
    #     get :index
    #     expect(assigns(:questions)).to eq([question])
    #   end
    # end

    describe "GET show" do
      it "returns http success" do
        get :show, params: { topic_id: topic.id, id: question.id }
        expect(response).to have_http_status(:success)
      end
    end


    describe "GET new" do

      it "returns http success" do
        topic.reload
        get :new, params: { topic_id: topic.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the new view" do
        topic.reload
        get :new, params: { topic_id: topic.id }
        expect(response).to render_template :new
      end


      it "instantiates @question" do
        topic.reload
        get :new, params: { topic_id: topic.id }
        expect(assigns(:question)).not_to be_nil
      end
    end

    describe "POST create" do

      # it "increases the number of Question by 1" do
      #   topic.reload
      #   expect{post :create, params: {topic_id: topic.id, question: { title: question.title, body: question.body } } }.to change(Question,:count).by(1)
      # end


      # it "assigns the new question to @question" do
      #   topic.reload
      #   post :create, params: { topic_id: topic.id, question: { title: question.title, body: question.body } }
      #   expect(assigns(:question)).to eq Question.last
      # end
      #
      #
      # it "redirects to the question post" do
      #   post :create, params: { topic_id: topic.id, question: { title: question.title, body: question.body } }
      #   expect(response).to redirect_to [topic, Question.last]
      # end
    end

    describe "GET edit" do

      it "returns http success" do
        get :edit, { params: { topic_id: topic.id, id: question.id} }
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit,  { params: { topic_id: topic.id, id: question.id} }
        expect(response).to render_template :edit
      end

      it "assigns question to be updated to @question" do
        get :edit,  { params: { topic_id: topic.id, id: question.id} }

        question_instance = assigns(:question)

        expect(question_instance.id).to eq question.id
        expect(question_instance.title).to eq question.title
        expect(question_instance.body).to eq question.body
      end
    end

    describe "PUT update" do

      it "updates question with expected attributes" do
        new_title = "Updated title"
        new_body = "This is an updated body."

        put :update, params: { topic_id: topic.id, id: question.id, question: {title: new_title, body: new_body} }

        updated_question = assigns(:question)
        expect(updated_question.id).to eq question.id
        expect(updated_question.title).to eq new_title
        expect(updated_question.body).to eq new_body
      end

      it "redirects to the updated question" do

        new_title = "Updated title"
        new_body = "This is an updated body."

        put :update, params: { topic_id: topic.id, id: question.id, question: {title: new_title, body: new_body} }
        expect(response).to redirect_to [topic, question]
      end
    end

    describe "DELETE destroy" do

      it "deletes the question" do
        delete :destroy, params: { topic_id: topic.id, id: question.id }
        count = Question.where({id: question.id}).size
        expect(count).to eq 0
      end

      it "redirects to topic show" do
        delete :destroy, params: { topic_id: topic.id, id: question.id }
        expect(response).to redirect_to topic
      end
    end
  end

  context "admin user doing CRUD on a post they don't own" do
    before do
      other_user.admin!
      sign_in other_user
    end

    # describe "GET index" do
    #
    #   before do
    #     sign_in user
    #   end
    #
    #   it "returns http success" do
    #     get :index
    #     expect(response).to have_http_status(:success)
    #   end
    #
    #   it "assigns [question] to @questions" do
    #     get :index
    #     expect(assigns(:questions)).to eq([question])
    #   end
    # end

    describe "GET show" do
      it "returns http success" do
        get :show, params: { topic_id: topic.id, id: question.id }
        expect(response).to have_http_status(:success)
      end
    end


    describe "GET new" do

      it "returns http success" do
        topic.reload
        get :new, params: { topic_id: topic.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the new view" do
        topic.reload
        get :new, params: { topic_id: topic.id }
        expect(response).to render_template :new
      end


      it "instantiates @question" do
        topic.reload
        get :new, params: { topic_id: topic.id }
        expect(assigns(:question)).not_to be_nil
      end
    end

    describe "POST create" do

      # it "increases the number of Question by 1" do
      #   topic.reload
      #   expect{post :create, params: {topic_id: topic.id, question: { title: question.title, body: question.body } } }.to change(Question,:count).by(1)
      # end


      # it "assigns the new question to @question" do
      #   topic.reload
      #   post :create, params: { topic_id: topic.id, question: { title: question.title, body: question.body } }
      #   expect(assigns(:question)).to eq Question.last
      # end
      #
      #
      # it "redirects to the question post" do
      #   post :create, params: { topic_id: topic.id, question: { title: question.title, body: question.body } }
      #   expect(response).to redirect_to [topic, Question.last]
      # end
    end

    describe "GET edit" do

      it "returns http success" do
        get :edit, { params: { topic_id: topic.id, id: question.id} }
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit,  { params: { topic_id: topic.id, id: question.id} }
        expect(response).to render_template :edit
      end

      it "assigns question to be updated to @question" do
        get :edit,  { params: { topic_id: topic.id, id: question.id} }

        question_instance = assigns(:question)

        expect(question_instance.id).to eq question.id
        expect(question_instance.title).to eq question.title
        expect(question_instance.body).to eq question.body
      end
    end

    describe "PUT update" do

      it "updates question with expected attributes" do
        new_title = "Updated title"
        new_body = "This is an updated body."

        put :update, params: { topic_id: topic.id, id: question.id, question: {title: new_title, body: new_body} }

        updated_question = assigns(:question)
        expect(updated_question.id).to eq question.id
        expect(updated_question.title).to eq new_title
        expect(updated_question.body).to eq new_body
      end

      it "redirects to the updated question" do

        new_title = "Updated title"
        new_body = "This is an updated body."

        put :update, params: { topic_id: topic.id, id: question.id, question: {title: new_title, body: new_body} }
        expect(response).to redirect_to [topic, question]
      end
    end

    describe "DELETE destroy" do

      it "deletes the question" do
        delete :destroy, params: { topic_id: topic.id, id: question.id }
        count = Question.where({id: question.id}).size
        expect(count).to eq 0
      end

      it "redirects to topic show" do
        delete :destroy, params: { topic_id: topic.id, id: question.id }
        expect(response).to redirect_to topic
      end
    end
  end
end
