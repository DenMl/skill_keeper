require 'spec_helper'

describe "skill_groups" do

	subject { page }
	
	describe "skill_groups#index" do
		let(:user) { FactoryGirl.create(:user) }
		before(:each) do
			sign_in user
			visit skill_groups_path
		end

		  it { should have_title('Skills Groups') }
    	it { should have_content('All skill groups') }
    	it { should have_link('Create')}

    	describe "display all skill groups" do
    		before(:all) { FactoryGirl.create(:skill_group) }
      		after(:all)  { SkillGroup.delete_all }

      		it { should have_selector('table tbody tr:nth-of-type(1) td:nth-of-type(1)', text: 'Skill group 1')}
      		it { should have_selector('table tbody tr:nth-of-type(1) td:nth-of-type(2)', text: 'Skill group 1 short description.')}
      end
	end
end