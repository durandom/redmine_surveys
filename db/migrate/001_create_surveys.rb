class CreateSurveys < ActiveRecord::Migration
  def self.up
    create_table :surveys do |t|
      t.references :user
      t.references :project
      t.column :valid_until, :date
      t.column :max_answers, :integer, :default => 0
      t.column :allow_comment, :boolean, :default => false
      t.column :allow_edit, :boolean, :default => false
      t.column :subject, :string
      t.column :content, :text
      t.timestamps
    end
  end

  def self.down
    drop_table :surveys
  end
end
