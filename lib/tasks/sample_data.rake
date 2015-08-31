namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_skills
    make_candidates
    make_skill_groups
    make_report_templates
    make_skill_group_to_skill_relationship
    make_candidate_to_skill_relationship
    make_report_template_to_skill_group_relationship
  end
end

def make_users
  admin = User.create!(name:     "admin",
                       email:    "admin@test.com",
                       password: "123456",
                       password_confirmation: "123456",
                       admin: true)
  10.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_skills
  40.times do |i|
    Skill.create!(name: "Skill #{i}", description: Faker::Lorem.sentence(5) )
  end
end

def make_candidates
    20.times do
     Candidate.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, patronymic: Faker::Name.first_name )
    end
end

def make_skill_groups
  15.times do |i|
    SkillGroup.create!(name: "Skill group #{i}", description: Faker::Lorem.sentence(10) )
  end
end

def make_report_templates
  10.times do |i|
    ReportTemplate.create!(name: "Template #{i}", description: Faker::Lorem.sentence(7) )
  end
end


def make_skill_group_to_skill_relationship

  SkillGroup.all.each do |skillGroup|
    skillIds = Skill.all.ids.to_a.shuffle[0..rand(4)]
    skillIds.each do |skillId|
      SkillGroupToSkillRelationship.create!(skill_id: skillId, skill_group_id: skillGroup.id )
      end
  end
end

def make_candidate_to_skill_relationship

  Candidate.all.each do |candidate|
    ids = Skill.all.ids.to_a.shuffle[0..rand(10)]
    ids.each do |id|
      CandidateToSkillRelationship.create!(skill_id: id, candidate_id: candidate.id )
    end
  end
end

def make_report_template_to_skill_group_relationship

  ReportTemplate.all.each do |report|
    ids = SkillGroup.all.ids.to_a.shuffle[0..rand(8)]
    ids.each do |id|
      ReportTemplateToSkillGroupRelationship.create!(report_template_id: id, skill_group_id: report.id )
    end
  end
end
