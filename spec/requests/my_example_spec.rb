require 'spec_helper'
require 'capybara'

describe 'My behaviour' do

  let(:user) { FactoryGirl.create(:user) }
  before(:each) do
    sign_in user
    visit skill_groups_path
  end

  it 'should do something', js: true do
    click_on 'Create'
    page.should have_content 'Name'
  end
end