class AddCommentHintToSurveys < ActiveRecord::Migration
  def self.up
    add_column :surveys, :comment_hint, :text
  end

  def self.down
    remove_column :surveys, :comment_hint
  end
end
