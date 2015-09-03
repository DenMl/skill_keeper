require 'spec_helper'
require 'capybara'

describe 'Skill Group page' do

  let!(:user) {FactoryGirl.create(:user)}

  before(:each) do
    sign_in user
    visit skill_groups_path
  end

  it 'create skill group item', js: true do
    click_on 'Create'
    fill_in 'skill_group_name', with: 'Fake Skill Group'
    fill_in 'skill_group_description', with: 'Fake Skill Group description'
    click_on 'Accept'
    page.should have_content 'Fake Skill Group'
    page.should have_content 'Fake Skill Group description'
  end
end