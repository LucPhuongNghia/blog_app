require "rails_helper"

RSpec.feature "Showing an Article" do
    
    before do
        @john = User.create(email: 'john@example.com', password: 'password')
        @jo = User.create(email: 'jo@example.com', password: 'password')
        @article = Article.create(title: "The first article", body: "Body of first article", user: @john)
    end
    
    scenario "A non signed in user do not see link edit or delete" do
       visit "/"
       
       click_link @article.title
       
       expect(page).to have_content(@article.title)
       expect(page).to have_content(@article.body)
       expect(current_path).to eq(article_path(@article))
       
       expect(page).not_to have_link("Edit Article")
       expect(page).not_to have_link("Delete Article")
    end
    
    scenario "A none owner signed in cannot see both links" do
       login_as(@jo)
       visit "/"
       
       click_link @article.title
       
       expect(page).not_to have_link("Edit Article")
       expect(page).not_to have_link("Delete Article")
    end
    
    scenario "Signed in article owner can see both links" do
       login_as(@john)
       visit "/"
       
       click_link @article.title
       
       expect(page).to have_link("Edit Article")
       expect(page).to have_link("Delete Article")
    end
    
    
    
    scenario "Display individual article" do
       
       visit "/"
       
       click_link @article.title
       
       expect(page).to have_content(@article.title)
       expect(page).to have_content(@article.body)
       expect(current_path).to eq(article_path(@article))
       
    end
    
end