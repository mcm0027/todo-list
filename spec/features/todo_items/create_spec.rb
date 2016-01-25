require 'spec_helper'

describe "Adding to do items" do
    let!(:todo_list) { TodoList.create(title: "Grocery list", description: "Groceries") }
    
    def visit_todo_list(list)
        visit "/todo_lists"
        within "#todo_list_#{list.id}" do
            click_link "List Items" 
        end
    end
   
   it "is successful with valid content" do
        visit_todo_list(todo_list)
        click_link "New Todo Item"
        fill_in "Content", with: "Milk"
        click_button "Save"
        expect(page).to have_content("Added todo list item.")
        within('ul.todo_items') do
            expect(page).to have_content("Milk") 
        end
    end
    
    it "displays an error when no content" do
        visit_todo_list(todo_list)
        click_link "New Todo Item"
        fill_in "Content", with: ""
        click_button "Save"
        within("div.flash") do
            expect(page).to have_content("There was a problem adding that item.")
        end
        expect(page).to have_content("Content can't be blank")
    end
    
     it "displays an error when less than 2 chars" do
        visit_todo_list(todo_list)
        click_link "New Todo Item"
        fill_in "Content", with: "a"
        click_button "Save"
        within("div.flash") do
            expect(page).to have_content("There was a problem adding that item.")
        end
        expect(page).to have_content("Content is too short")
    end
end