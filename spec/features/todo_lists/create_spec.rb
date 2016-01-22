require 'spec_helper'

describe "Creating to do lists" do
    
    def creat_todo_list(options={})
        options[:title] ||= "My todo list"
        options[:description] ||= "This is my todo list."
        
        visit  "/todo_lists"
        click_link "New Todo list"
        expect(page).to have_content("New Todo List")
        
        fill_in "Title", with: options[:title]
        fill_in "Description", with: options[:description]
        click_button "Create Todo list"
        
    end
        
   it "redirects to the todo list index pageon success" do

        creat_todo_list(title: "")
        
        expect(page).to have_content("My todo list")
    end
    
    it "displays an error when todo list has no title" do
        expect(TodoList.count).to eq(0)
    
        creat_todo_list(title: "hi")
        
        expect(page).to have_content("error")
        expect(TodoList.count).to eq(0)
        
        visit "/todo_lists"
        expect(page).to_not have_content("This is what I'm doing today.")
    end
    
    it "displays an error when todo list has a title less than three characters" do
        expect(TodoList.count).to eq(0)
    
        visit  "/todo_lists"
        click_link "New Todo list"
        expect(page).to have_content("New Todo List")
        
        fill_in "Title", with: "Hi"
        fill_in "Description", with: "This is what I'm doing today."
        click_button "Create Todo list"
        
        expect(page).to have_content("error")
        expect(TodoList.count).to eq(0)
        
        visit "/todo_lists"
        expect(page).to_not have_content("This is what I'm doing today.")
    end
    
    it "displays an error when todo list has no description." do
        expect(TodoList.count).to eq(0)
    
        visit  "/todo_lists"
        click_link "New Todo list"
        expect(page).to have_content("New Todo List")
        
        fill_in "Title", with: "Hello"
        fill_in "Description", with: ""
        click_button "Create Todo list"
        
        expect(page).to have_content("error")
        expect(TodoList.count).to eq(0)
        
        visit "/todo_lists"
        expect(page).to_not have_content("Hello")
    end
    
    it "displays an error when todo list has less than 5 char description." do
        expect(TodoList.count).to eq(0)
    
        visit  "/todo_lists"
        click_link "New Todo list"
        expect(page).to have_content("New Todo List")
        
        fill_in "Title", with: "Hello"
        fill_in "Description", with: "what"
        click_button "Create Todo list"
        
        expect(page).to have_content("error")
        expect(TodoList.count).to eq(0)
        
        visit "/todo_lists"
        expect(page).to_not have_content("Hello")
    end
end