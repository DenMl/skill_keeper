class CreateReportTemplates < ActiveRecord::Migration
  def change
    create_table :report_templates do |t|
      t.string :name
      t.string :description

      t.timestamps
    end

    add_index :report_templates, :name, unique: true

  end
end
