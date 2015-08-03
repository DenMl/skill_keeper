class CreatePersonToSkillGroupRelationships < ActiveRecord::Migration
  def change
    create_table :person_to_skill_group_relationships do |t|
      t.integer :person_id
      t.integer :skill_id

      t.timestamps
    end
  end
end
