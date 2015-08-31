require 'spec_helper'

describe "Report pages" do
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  subject { page }

  describe "index" do
    before { visit reports_path }

    it { should have_title('Reports') }
    it { should have_content('Reports') }

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:report_template) } }
      after(:all) { ReportTemplate.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each report template" do
        ReportTemplate.paginate(page: 1, per_page: 15).each do |report_template|
          expect(page).to have_selector('tbody tr td:first-child', text: report_template.name)
        end
      end
    end

    describe "generate links" do
      it { should_not have_link('Generate') }
    end
  end

  describe "show" do

    let(:skill1) { FactoryGirl.create(:skill) }
    let(:skill2) { FactoryGirl.create(:skill) }
    let(:skill3) { FactoryGirl.create(:skill) }

    let(:candidate1) {
      candidate = FactoryGirl.create(:candidate)
      candidate.candidate_to_skill_relationships.create(skill_id: skill1.id)
      candidate.candidate_to_skill_relationships.create(skill_id: skill2.id)
      candidate
    }

    let(:candidate2) {
      candidate = FactoryGirl.create(:candidate)
      candidate.candidate_to_skill_relationships.create(skill_id: skill2.id)
      candidate.candidate_to_skill_relationships.create(skill_id: skill3.id)
      candidate
    }

    let(:candidate3) {
      candidate = FactoryGirl.create(:candidate)
      candidate.candidate_to_skill_relationships.create(skill_id: skill3.id)
      candidate
    }

    let(:skill_group1) {
      skill_group = FactoryGirl.create(:skill_group)
      skill_group.skill_group_to_skill_relationships.create(skill_id: skill1.id)
      skill_group.skill_group_to_skill_relationships.create(skill_id: skill2.id)
      skill_group
    }

    let(:skill_group2) {
      skill_group = FactoryGirl.create(:skill_group)
      skill_group.skill_group_to_skill_relationships.create(skill_id: skill2.id)
      skill_group.skill_group_to_skill_relationships.create(skill_id: skill3.id)
      skill_group
    }

    let(:report_template) {
      report_template = FactoryGirl.create(:report_template)
      report_template.report_template_to_skill_group_relationships.create(skill_group_id: skill_group1.id)
      report_template.report_template_to_skill_group_relationships.create(skill_group_id: skill_group2.id)
      report_template
    }

    before { visit report_path(report_template) }

    it { should have_title(report_template.name) }
    it { should have_content(report_template.name) }

    it "should list each skill group of the template" do
      report_template.skill_groups.each do |skill_group|
        expect(page).to have_selector('tbody tr td:first-child div p', text: skill_group.name)
      end
    end

    it "should list count of candidates per every skill group" do
      report_template.skill_groups.each do |skill_group|
        expect(page).to have_selector('tbody tr td:nth-child(3) h4', text: skill_group.candidates.count)
      end
    end

  end

end