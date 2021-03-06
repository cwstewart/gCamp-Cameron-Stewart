require 'rails_helper'

describe "user can CRUD projects" do
  before :each, 'user logs in' do
    @user = User.create(first_name: "Cameron", last_name: "Stew", email: "cam@awesome.com", password: "awesome", password_confirmation: "awesome")
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign In'
    expect(page).to have_content "#{@user.first_name} #{@user.last_name}"
    visit('/projects')
  end

  it 'User can see project index page' do
    expect(page).to have_content 'New Project'
  end

  it "User can create project and view show page" do
    within('.pull-right') do
      click_link 'New Project'
    end
      expect(page).to have_content 'Create Project'
      fill_in 'Name', with: 'Awesome Project!'
      click_button 'Create Project'
      expect(page).to have_content 'Project was successfully created.'
  end

  it 'User can edit existing project' do
    visit("/projects")
    within('.pull-right') do
      click_link 'New Project'
    end
      expect(page).to have_content 'Create Project'
      fill_in 'Name', with: 'Awesome Project!'
      click_button 'Create Project'
      expect(page).to have_content 'Project was successfully created.'
      within('.breadcrumb') do
        click_link 'Awesome Project!'
      end
      expect(page).to have_content 'Edit'
  end

  it "User can delete existing project" do
    visit("/projects")
    within('.pull-right') do
      click_link 'New Project'
    end
      expect(page).to have_content 'Create Project'
      fill_in 'Name', with: 'Awesome Project!'
      click_button 'Create Project'
      expect(page).to have_content 'Project was successfully created.'
      within('.breadcrumb') do
        click_link 'Awesome Project!'
      end
      expect(page).to have_content 'Delete'
      click_link 'Delete'
      expect(page).to have_content 'Project was successfully deleted'
  end

end
