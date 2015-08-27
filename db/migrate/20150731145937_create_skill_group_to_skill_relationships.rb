class CreateSkillGroupToSkillRelationships < ActiveRecord::Migration
  def change
    create_table :skill_group_to_skill_relationships do |t|
      t.integer :skill_group_id
      t.integer :skill_id

      t.timestamps
    end

    add_index :skill_group_to_skill_relationships, [:skill_id, :skill_group_id], unique: true, name: 'index_skill_group_id_to_skill_id'
  end
end
