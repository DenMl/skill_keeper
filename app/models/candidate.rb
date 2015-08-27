class Candidate < ActiveRecord::Base

  has_many :candidate_to_skill_relationships, dependent: :destroy
  has_many :skills, through: :candidate_to_skill_relationships

end
