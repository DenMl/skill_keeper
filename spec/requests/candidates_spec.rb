require 'spec_helper'

describe 'candidates' do

  subject { page }

  describe 'candidates#index' do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      sign_in user
      visit candidates_path
    end

    it { should have_title('All candidates') }
    it { should have_content('All candidates') }

    describe 'display all candidates' do
      before(:all) { FactoryGirl.create(:candidate) }
      after(:all)  { Candidate.delete_all }

      it { should have_selector('table tbody tr:nth-of-type(1) td:nth-of-type(1)', text: 'Last Name 1')}
      it { should have_selector('table tbody tr:nth-of-type(1) td:nth-of-type(2)', text: 'First Name 1')}
      it { should have_selector('table tbody tr:nth-of-type(1) td:nth-of-type(3)', text: 'Patronymic 1')}
    end
  end
end