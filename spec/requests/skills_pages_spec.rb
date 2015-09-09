require 'spec_helper'
require 'capybara'

describe 'skills' do

	subject { page }
	let!(:user) {FactoryGirl.create(:user)}
	let!(:skill) {FactoryGirl.create(:skill)}

	before(:each) do
		sign_in user
		visit skills_path
	end

	describe 'index.html.erb' do
		it do
			should have_title('All skills')
			should have_content('All skills')
			should have_link('Create')
		end
	end

	describe '.create', js: true do
		before do
			click_on 'Create'
      wait_for_ajax
			fill_in 'skill_name', with: 'Fake Skill'
			fill_in 'skill_description', with: 'Fake Skill description'
			click_on 'Accept'
      wait_for_ajax
		end
		it do
			should have_content 'Fake Skill'
			should have_content 'Fake Skill description'
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
      wait_for_ajax
			fill_in 'skill_name', with: 'Edited Skill'
			fill_in 'skill_description', with: 'Edited Skill description'
			click_on 'Accept'
			wait_for_ajax
		end
		it do
			should have_content 'Edited Skill'
			should have_content 'Edited Skill description'
		end
	end

	describe '.create (invalid name)', js: true do
		before do
			FactoryGirl.create(:skill, name: 'Skill')
			click_on 'Create'
			fill_in 'skill_name', with: 'Skill'
			click_on 'Accept'
      wait_for_ajax
		end
		it do
			should have_selector '.list-group-item-danger'
		end
	end

end