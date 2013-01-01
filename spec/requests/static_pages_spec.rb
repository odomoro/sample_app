require 'spec_helper'

describe "Static pages" do
  
   let(:b_t) { "Ruby on Rails Tutorial Sample App" }
   let(:b_p) {"/static_pages"}

  describe "Home page" do

    it "should have the h1 'Sample App'" do
      visit "#{b_p}/home"
      page.should have_selector('h1', :text => 'Sample App')
    end

    it "should have the base title" do
      visit "#{b_p}/home"
      page.should have_selector('title',
                        :text =>  "#{b_t}")
    end
    
     it "should not have a custom page title" do
      visit "#{b_p}/home"
      page.should_not have_selector('title', :text => '| Home')
    end
    
  end

  describe "Help page" do

    it "should have the h1 'Help'" do
      visit "#{b_p}/help"
      page.should have_selector('h1', :text => 'Help')
    end

    it "should have the title 'Help'" do
      visit "#{b_p}/help"
      page.should have_selector('title',
                        :text =>  "#{b_t} | Help")
    end
  end

  describe "About page" do

    it "should have the h1 'About Us'" do
      visit "#{b_p}/about"
      page.should have_selector('h1', :text => 'About Us')
    end

    it "should have the title 'About Us'" do
      visit "#{b_p}/about"
      page.should have_selector('title',
                    :text =>  "#{b_t} | About Us")
    end
  end
  
  describe "Contact page" do

    it "should have the h1 'Contact'" do
      visit "#{b_p}/contact"
      page.should have_selector('h1', :text => 'Contact')
    end

    it "should have the title 'Contact'" do
      visit "#{b_p}/contact"
      page.should have_selector('title',
                    :text =>  "#{b_t} | Contact")
    end
  end
end



