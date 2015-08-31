require 'spec_helper'

describe 'My behaviour' do
  let(:user) { FactoryGirl.create(:user) }
  before(:each) do
    sign_in user
    visit skill_groups_url
  end

  it 'should do something', js: true do
    visit 'http://localhost:3000/skill_groups'
    click_on 'Create'
    page.should have_content 'New Skill Group'
  end
end