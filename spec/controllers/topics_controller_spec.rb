require 'rails_helper'

RSpec.describe TopicsController, type: :controller do
  let(:user) { create(:user) }
  let(:topic) { create(:topic) }

  context "guest" do
    describe "GET index" do

      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      # it "assigns Topic.all to @topic" do
      #   get :index
      #   expect(assigns(:topics)).to eq([topic])
      # end

      # it "does not include private topics in @topics" do
      #   get :index
      #   expect(assigns(:topics)).not_to include(my_private_topic)
      # end
    end


    describe "GET show" do

      # it "redirects from private topics" do
      #   get :show, {id: my_private_topic.id}
      #   expect(response).to redirect_to(new_session_path)
      # end

      it "returns http success" do
        get :show, params: {id: topic.id}
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, params: {id: topic.id}
        expect(response).to render_template :show
      end

      it "assigns topic to @topic" do
        get :show, params: {id: topic.id}
        expect(assigns(:topic)).to eq(topic)
      end
    end

    describe "GET new" do
      it "returns http redirect" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "POST create" do
      it "returns http redirect" do
        post :create, params: { topic: {name: topic.name, description: topic.description } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET edit" do
      it "returns http redirect" do
        get :edit, params: {id: topic.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "PUT update" do
      it "returns http redirect" do
        new_name = "Edited name"
        new_description = "This desctiption has been edited."

        put :update, params: { id: topic.id, topic: {name: new_name, description: new_description } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, params: {id: topic.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end


  context "member user" do

    before do
      sign_in user
      # user.role = "#{member}"
    end

    describe "GET index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      # it "assigns Topic.all to @topic" do
      #   get :index
      #   expect(assigns(:topics)).to eq([topic])
      # end

      # it "does not include private topics in @topics" do
      #   get :index
      #   expect(assigns(:topics)).not_to include(my_private_topic)
      # end
    end


    describe "GET show" do

      # it "redirects from private topics" do
      #   get :show, {id: my_private_topic.id}
      #   expect(response).to redirect_to(new_session_path)
      # end

      it "returns http success" do
        get :show, params: {id: topic.id}
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, params: {id: topic.id}
        expect(response).to render_template :show
      end

      it "assigns topic to @topic" do
        get :show, params: {id: topic.id}
        expect(assigns(:topic)).to eq(topic)
      end
    end

    describe "GET new" do
      it "returns http redirect" do
        get :new
        expect(response).to redirect_to(topics_path)
      end
    end

    describe "POST create" do
      it "returns http redirect" do
        post :create, params: { topic: {name: topic.name, description: topic.description } }
        expect(response).to redirect_to(topics_path)
      end
    end

    describe "GET edit" do
      it "returns http redirect" do
        get :edit, params: {id: topic.id}
        expect(response).to redirect_to(topics_path)
      end
    end

    describe "PUT update" do
      it "returns http redirect" do
        new_name = "Edited name"
        new_description = "This desctiption has been edited."

        put :update, params: { id: topic.id, topic: {name: new_name, description: new_description } }
        expect(response).to redirect_to(topics_path)
      end
    end

    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, params: {id: topic.id}
        expect(response).to redirect_to(topics_path)
      end
    end
  end


  context "admin user" do
    before do
      sign_in user
      user.role = "admin"
    end

    describe "GET index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      # it "assigns topic to @topics" do
      #   get :index
      #   expect(assigns(:topics)).to eq([topic])
      # end
    end

    describe "GET show" do
      it "returns http success" do
        get :show, params: {id: topic.id}
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, params: {id: topic.id}
        expect(response).to render_template :show
      end

      it "assigns topic to @topic" do
        get :show, params: {id: topic.id}
        expect(assigns(:topic)).to eq(topic)
      end
    end

    describe "GET new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "renders the #new view" do
        get :new
        expect(response).to render_template :new
      end

      it "initializes @topic" do
        get :new
        expect(assigns(:topic)).not_to be_nil
      end
    end

    describe "POST create" do
      # it "increases the number of topics by 1" do
      #   expect{ post :create, params: { topic: {name: topic.name, description: topic.description } } }.to change(Topic,:count).by(1)
      # end

      it "assigns Topic.last to @topic" do
        sign_in user
        post :create, params: { topic: {name: topic.name, description: topic.description } }
        expect(assigns(:topic)).to eq Topic.last
      end

      it "redirects to the new topic" do
        sign_in user
        post :create, params: { topic: {name: topic.name, description: topic.description } }
        expect(response).to redirect_to Topic.last
      end
    end

    describe "GET edit" do
      it "returns http success" do
        get :edit, params: {id: topic.id}
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, params: {id: topic.id}
        expect(response).to render_template :edit
      end

      it "assigns topic to be updated to @topic" do
        get :edit, params: {id: topic.id}
        topic_instance = assigns(:topic)

        expect(topic_instance.id).to eq topic.id
        expect(topic_instance.name).to eq topic.name
        expect(topic_instance.description).to eq topic.description

      end
    end


    describe "PUT update" do
      it "updates topic with expected attributes" do
        new_name = "Edited name"
        new_description = "This desctiption has been edited."
        updated_topic = topic
        put :update, params: { id: updated_topic.id, topic: {name: new_name, description: new_description } }
        updated_topic.reload

        expect(updated_topic.id).to eq topic.id
        expect(updated_topic.name).to eq new_name
        expect(updated_topic.description).to eq new_description
      end

      it "redirects to the updated topic" do
        new_name = "Edited name"
        new_description = "This desctiption has been edited."

        put :update, params: { id: topic.id, topic: {name: new_name, description: new_description } }
        expect(response).to redirect_to topic
      end
    end

    describe "DELETE destroy" do
      it "deletes the topic" do
        delete :destroy, params: {id: topic.id}
        count = Topic.where({id: topic.id}).size
        expect(count).to eq 0
      end

      it "redirects to topics index" do
        delete :destroy, params: {id: topic.id}
        expect(response).to redirect_to topics_path
      end
    end

  end
end
