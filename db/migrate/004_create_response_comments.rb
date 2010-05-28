class CreateResponseComments < ActiveRecord::Migration
  def self.up
    create_table :response_comments do |t|
      t.references :user
      t.references :survey
      t.column :content, :text
    end
  end

  def self.down
    drop_table :response_comments
  end
end
