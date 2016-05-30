require 'rails_helper'
require 'support/macros'

RSpec.describe ArticlesController, type: :controller do

  describe "GET #edit" do
    before do
      @john = User.create(email: 'john@example.com', password: 'password')
    end
    
    context "Owner is allowed to edit his article" do
      it "render the edit template" do
        login_user @john
        article = Article.create(title: 'first article', body: 'Body of first article', user: @john)
        get :edit, id: article
        
        expect(response).to render_template :edit
      end
    end
    
    context "none owner are not allowed to edit other users articles" do
      it "redirect to the root path" do
        jo = User.create(email: 'jo@example.com', password: 'password')
        login_user jo
        article = Article.create(title: 'first article', body: 'Body of first article', user: @john)
        get :edit, id: article
        
        expect(response).to redirect_to(root_path)
        message = "You can only edit your own articles"
        expect(flash[:danger]).to eq(message) 
      end
    end
    
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
