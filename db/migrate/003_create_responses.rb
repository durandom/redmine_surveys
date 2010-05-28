class CreateResponses < ActiveRecord::Migration
  def self.up
    create_table :responses do |t|
      t.references :user
      t.references :answer
    end
  end

  def self.down
    drop_table :responses
  end
end
