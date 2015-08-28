class Candidate < ActiveRecord::Base

  has_many :candidate_to_skill_relationships, dependent: :destroy
  has_many :skills, through: :candidate_to_skill_relationships

  def self.from_skill_group (skill_group)
    where('id IN (SELECT DISTINCT c.candidate_id FROM candidate_to_skill_relationships c LEFT JOIN skill_group_to_skill_relationships s on c.skill_id=s.skill_id WHERE s.skill_group_id=:skill_group_id)', skill_group_id: skill_group.id)
  end

end
