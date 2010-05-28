class ChangeSurveysAgain < ActiveRecord::Migration
  def self.up
    rename_column :surveys, :mutiple_choice, :multiple_choice
    change_column_default :surveys, :allow_comment, true
    change_column_default :surveys, :allow_edit, true
  end

  def self.down
    rename_column :surveys, :multiple_choice, :mutiple_choice
    change_column_default :surveys, :allow_comment, false
    change_column_default :surveys, :allow_edit, false
  end
end
