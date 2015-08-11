require 'spec_helper'

describe "Skills page" do

	subject { page }
	
	describe "skill list" do
		let(:user) { FactoryGirl.create(:user) }
		let(:skills) { 10.times { FactoryGirl.create(:skill) } }
		before(:each) do
			sign_in user
			visit skills_path
		end

		it { should have_title('All skills') }
    	it { should have_content('All skills') }
	end
end