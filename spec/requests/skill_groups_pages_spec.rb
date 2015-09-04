require 'spec_helper'
require 'capybara'

describe 'skill_group' do

  subject { page }
  let!(:user) {FactoryGirl.create(:user)}
  let!(:skill_group) {FactoryGirl.create(:skill_group)}

  before(:each) do
    sign_in user
    visit skill_groups_path
  end

  describe 'index.html.erb' do
    it do
      should have_title('Skills Groups')
      should have_content('All skill groups')
      should have_link('Create')
    end
  end

  describe '.create', js: true do
    before do
      click_on 'Create'
      fill_in 'skill_group_name', with: 'Fake Skill Group'
      fill_in 'skill_group_description', with: 'Fake Skill Group description'
      click_on 'Accept'
    end
    it do
      should have_content 'Fake Skill Group'
      should have_content 'Fake Skill Group description'
    end
  end

  describe '.delete', js: true do
    before do
      find(:css, 'table tbody tr:nth-of-type(1)').find_link('Delete').click
      click_on 'Accept'
      wait_for_ajax
    end
    it do
      within('.table') do
        should_not have_link 'Delete'
        should_not have_link 'Edit'
      end
    end
  end

  describe '.edit', js: true do
    before do
      find(:css, 'table tbody tr:nth-of-type(1)').find_link('Edit').click
      fill_in 'skill_group_name', with: 'Edited Skill Group'
      fill_in 'skill_group_description', with: 'Edited Skill Group description'
      click_on 'Accept'
    end
    it do
      should have_content 'Edited Skill Group'
      should have_content 'Edited Skill Group description'
    end
  end

  describe '.create (invalid name)', js: true do
    before do
      FactoryGirl.create(:skill_group, name: 'Skill Group')
      click_on 'Create'
      fill_in 'skill_group_name', with: 'Skill Group'
      click_on 'Accept'
    end
    it do
      should have_selector '.list-group-item-danger'
    end
  end

  describe '.add_skill', js: true do
    before do
      10.times {FactoryGirl.create(:skill)}
      find(:css, 'table tbody tr:nth-of-type(1)').find_link('Edit').click
      fill_in 's2id_autogen1', with: 'Skill 1'
      select2('Skill 1', css: '#s2id_skillsSelector')
      wait_for_ajax
      fill_in 's2id_autogen1', with: 'Skill 2'
      select2('Skill 2', css: '#s2id_skillsSelector')
      wait_for_ajax
      click_on 'Accept'
      find(:css, 'table tbody tr:nth-of-type(1)').find_link('Edit').click
      wait_for_ajax
    end
    it do
      should have_selector 'ul.select2-choices li.select2-search-choice'
    end
  end
end