require 'spec_helper'

describe "skills" do

	subject { page }
	
	describe "skills#index" do
		let(:user) { FactoryGirl.create(:user) }
		before(:each) do
			sign_in user
			visit skills_path
		end

		it { should have_title('All skills') }
    	it { should have_content('All skills') }

    	describe "display all skills" do
    		before(:all) { FactoryGirl.create(:skill) }
      		after(:all)  { Skill.delete_all }

      		it { should have_selector('table tbody tr:nth-of-type(1) td:nth-of-type(1)', text: 'Skill 1')}
      		it { should have_selector('table tbody tr:nth-of-type(1) td:nth-of-type(2)', text: 'Skill 1 short description.')}
    	end
	end
end