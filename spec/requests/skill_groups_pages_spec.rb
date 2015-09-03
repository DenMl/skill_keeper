require 'spec_helper'
require 'capybara'

describe 'Skill Group page' do

  let!(:user) {FactoryGirl.create(:user)}
  let!(:skill_group) {FactoryGirl.create(:skill_group)}

  before(:each) do
    #FactoryGirl.create(:skill_group)
    sign_in user
    visit skill_groups_path
  end

  it 'have appropriate page structure ' do
    page.should have_title('Skills Groups')
    page.should have_content('All skill groups')
    page.should have_link('Create')
  end

  it 'create skill group item', js: true do
      click_on 'Create'
      fill_in 'skill_group_name', with: 'Fake Skill Group'
      fill_in 'skill_group_description', with: 'Fake Skill Group description'
      click_on 'Accept'
      page.should have_content 'Fake Skill Group'
      page.should have_content 'Fake Skill Group description'
  end

  it 'delete skill group item', js: true do
    find(:css, 'table tbody tr:nth-of-type(1)').find_link('Delete').click
    click_on 'Accept'
    page.should_not have_content 'Skill Group 2'
    page.should_not have_content 'Skill Group 2 short description'
  end

  it 'edit skill group item', js: true do
    find(:css, 'table tbody tr:nth-of-type(1)').find_link('Edit').click
    fill_in 'skill_group_name', with: 'Edited Skill Group'
    fill_in 'skill_group_description', with: 'Edited Skill Group description'
    click_on 'Accept'
    page.should have_content 'Edited Skill Group'
    page.should have_content 'Edited Skill Group description'
  end

end