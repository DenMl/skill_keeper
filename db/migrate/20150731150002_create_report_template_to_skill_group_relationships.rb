class CreateReportTemplateToSkillGroupRelationships < ActiveRecord::Migration
  def change
    create_table :report_template_to_skill_group_relationships do |t|
      t.integer :report_template_id
      t.integer :skill_group_id

      t.timestamps
    end
  end
end
