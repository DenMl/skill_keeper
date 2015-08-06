namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_skills
    make_persons
    make_skill_groups
    make_report_templates
    make_skill_group_to_skill_relationship
    make_person_to_skill_relationship
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
  60.times do |i|
    Skill.create!(name: "Skill #{i}", description: Faker::Lorem.sentence(5) )
  end
end

def make_persons
    50.times do
     Person.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, patronymic: Faker::Name.first_name )
    end
end

def make_skill_groups
  30.times do |i|
    SkillGroup.create!(name: "Skill group #{i}", description: Faker::Lorem.sentence(5) )
  end
end

def make_report_templates
  20.times do |i|
    ReportTemplate.create!(name: "Template #{i}", description: Faker::Lorem.sentence(5) )
  end
end


def make_skill_group_to_skill_relationship

  SkillGroup.all.each do |skillGroup|
    skillIds = Skill.all.ids.to_a.shuffle[0..15]
    skillIds.each do |skillId|
      SkillGroupToSkillRelationship.create!(skill_id: skillId, skill_group_id: skillGroup.id )
      end
  end
end

def make_person_to_skill_relationship

  Person.all.each do |person|
    ids = Skill.all.ids.to_a.shuffle[0..15]
    ids.each do |id|
      PersonToSkillRelationship.create!(skill_id: id, person_id: person.id )
    end
  end
end

def make_report_template_to_skill_group_relationship

  ReportTemplate.all.each do |report|
    ids = SkillGroup.all.ids.to_a.shuffle[0..5]
    ids.each do |id|
      ReportTemplateToSkillGroupRelationship.create!(report_template_id: id, skill_group_id: report.id )
    end
  end
end
