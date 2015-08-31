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

    candidate1 =  FactoryGirl.create(:candidate)
    candidate1.candidate_to_skill_relationships.create(skill_id: skill1.id)
    candidate1.candidate_to_skill_relationships.create(skill_id: skill2.id)

    let(:candidate2) { FactoryGirl.create(:candidate) }
    candidate2.candidate_to_skill_relationships.create(skill_id: skill2.id)
    candidate2.candidate_to_skill_relationships.create(skill_id: skill3.id)

    let(:candidate3) { FactoryGirl.create(:candidate) }
    candidate3.candidate_to_skill_relationships.create(skill_id: skill3.id)

    let(:skill_group1) { FactoryGirl.create(:skill_group) }
    skill_group1.skill_group_to_skill_relationships.create(skill_id: skill1.id)
    skill_group1.skill_group_to_skill_relationships.create(skill_id: skill2.id)

    let(:skill_group2) { FactoryGirl.create(:skill_group) }
    skill_group2.skill_group_to_skill_relationships.create(skill_id: skill2.id)
    skill_group2.skill_group_to_skill_relationships.create(skill_id: skill3.id)

    let(:report_template) { FactoryGirl.create(:report_template) }
    report_template.report_template_to_skill_group_relationships.create(skill_group_id: skill_group1.id)
    report_template.report_template_to_skill_group_relationships.create(skill_group_id: skill_group2.id)

    before { sign_in user }
    before { visit report_path(report_template) }

    it { should have_title(report_template.name) }
    it { should have_content(report_template.name) }

  end

end