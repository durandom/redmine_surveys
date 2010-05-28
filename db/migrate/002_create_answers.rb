class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.references :survey
      t.column :content, :text
    end
  end

  def self.down
    drop_table :answers
  end
end
