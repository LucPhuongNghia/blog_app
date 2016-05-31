require "rails_helper"

RSpec.feature "Adding review to articles" do
    before do
       @john = User.create(email: 'john@example.com', password: 'password') 
       @jo = User.create(email: 'jo@example.com', password: 'password')
       
       @article = Article.create(title: 'First Article', body: 'Body of first article', user: @john)
    end
    
    scenario "Permit signed in user to write review" do
       login_as(@jo)
       visit "/"
       click_link @article.title
       
       fill_in "New Comment", with: "An awesome article"
       click_button "Add Comment"
       
       expect(page).to have_content('Comment has been created')
       expect(page).to have_content('An awesome article')
       expect(current_path).to eq(article_path(@article.comments.last.id))
    end
end