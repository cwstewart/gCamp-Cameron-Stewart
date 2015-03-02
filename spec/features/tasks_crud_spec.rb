require 'rails_helper'

describe 'User can CRUD tasks' do

  before :each do
    @user = User.create(first_name: "Cameron", last_name: "Stew", email: "cam@awesome.com", password: "awesome", password_confirmation: "awesome")
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign In'

    @project = Project.create(name: 'Sweet Project')
    visit("/projects/#{@project.id}/tasks")
    expect(page).to have_content "No tasks for this project yet! "
  end


  it 'User can create task' do
    click_link 'New Task'
    expect(page).to have_content 'New Task'
    fill_in 'Description', with: 'Task 1'
    click_button 'Create Task'
    expect(page).to have_content 'Task 1'
  end

  it 'User can view task show page' do
    @task = Task.create(description: 'Task 2', due_date: '2/16/14', complete: false)
    visit("/projects/#{@project.id}/tasks/#{@task.id}")
    expect(page).to have_content @task.description
  end

  it 'User can edit task' do
    @task = Task.create(description: 'Task 2', due_date: '2/16/14', complete: false)
    visit("/projects/#{@project.id}/tasks/#{@task.id}")
    expect(page).to have_content @task.description
    click_link 'Edit'
    fill_in 'Description', with: 'Task 2 Update'
    click_button 'Update Task'
    expect(page).to have_content 'Task 2 Update'
  end

  it 'User can delete task' do
    @task = Task.create(description: 'Task 2', due_date: '2/16/14', complete: false)
    visit("/projects/#{@project.id}/tasks/#{@task.id}")
    expect(page).to have_content @task.description
    click_link 'Edit'
    click_link 'Delete Task'
    expect(page).to have_content 'Tasks'
  end


end
