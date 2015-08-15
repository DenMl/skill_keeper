class Candidate < ActiveRecord::Base

  has_many :skills, foreign_key: 'candidate_id',  class_name:  'CandidateToSkillRelationship', dependent: :destroy

end
