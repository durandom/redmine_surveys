class ChangeSurveysMaxNumber < ActiveRecord::Migration
  def self.up
    remove_column :surveys, :max_answers
    add_column :surveys, :mutiple_choice, :boolean, :default => true
  end

  def self.down
    remove_column :survey, :multiple_choice
    add_column :surveys, :max_answers, :integer, :default => 0
  end
end
