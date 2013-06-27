require 'redmine'


Redmine::Plugin.register :redmine_surveys do
  name 'Redmine Surveys plugin'
  author 'Marcel Hild'
  description 'This is a survey plugin for Redmine'
  version '0.0.2'

  project_module :surveys_module do
    permission :create_surveys, { :surveys => [:create, :edit, :update, :destroy, :download, :new] }
    permission :view_surveys, { :surveys => [:index, :respond, :show] }
    permission :view_surveys_results, { :surveys => [ :results ] }
  end
  
  menu :project_menu, :surveys, { :controller => 'surveys', :action => 'index' },
    :caption => 'Surveys', :after => :wiki, :param => :project_id
end
