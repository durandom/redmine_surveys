class SurveysController < ApplicationController
  unloadable

  layout 'base'
  before_filter :find_survey_and_project, :except => :preview
  before_filter :authorize, :except => :preview


  def index
    @surveys = Survey.find_all_by_project_id(@project)
  end
  
  def new
    @survey = Survey.new
    @survey.valid_until = Time.now.advance(:days => 30)
  end

  def create
    @survey = Survey.new(params[:survey])
    @survey.project = @project
    @survey.user = User.current
    if @survey.save
      add_answers(params[:answers])
      redirect_to :action => 'index', :id => @survey, :anchor => @survey.id
    end      
  end
  
  def edit
  end
  
  def update
    if params[:survey] && @survey.update_attributes(params[:survey])
      # update existing questions
      params[:existing_answers].each do |id, a|
        answer = Answer.find(id)
        answer.content = a[:content]
        answer.save
      end
      # add new answers
      add_answers(params[:answers])
      redirect_to :action => 'index', :id => @survey, :anchor => @survey.id
    end
  end
  
  def show
  end
  
  def results
  end
  
  def download
    require 'csv'
    user_fields = ['login', 'lastname', 'firstname', 'mail']
    # hash of { custom_field_id => name }
    user_custom_fields = Hash[ User.current.available_custom_fields.collect {|f| [f.id, f.name] } ]      
    csv_string = CSV.generate(:col_sep => ";", :row_sep => "\r\n") do |csv|
      # add a header line
      header = []
      @survey.answers.each do |answer|
        header << answer.content
      end
      header << 'Comment'
      header += user_fields
      header += user_custom_fields.values
      csv << header
      
      # add rows for each user
      @survey.responders.each do |user|
        row = []
        # add answers
        @survey.answers.each do |answer|
          row << (answer.responses.find_by_user_id(user.id) ? 1 : 0)
        end
        # add comment
        row << @survey.response_comments.find_by_user_id(user.id).try(:content)
        
        # add user info
        user_fields.each do |field| 
          row << user.send(field)
        end
        # add custom fields
        user_custom_fields.each_key do |field_id|
          row << user.custom_value_for(field_id).try(:value)
        end
        csv << row
      end
    end
    send_data csv_string, 
        :type => "text/csv",
        :filename=> "survey_#{'%02i' % @survey.id}.csv",
        :disposition => 'attachment'

  end 

  def respond
    if @survey.is_valid?
      @survey.remove_response_by_user(User.current)
      if params[:response]
        # remove answers for this user first
        params[:response].each do |r|
          respond_to(r)
        end
      end
      if params[:comment] && !params[:comment].empty? 
        @response_comment = ResponseComment.new
        @response_comment.content = params[:comment]
        @response_comment.survey = @survey
        @response_comment.user = User.current
        @response_comment.save
      end
    end
    redirect_to :action => 'index', :project_id => @survey.project.identifier, :anchor => @survey.id
  end
  
  def preview
    @survey = Survey.new(params[:survey])
    @answers = []
    params[:answers].is_a?(Hash) && params[:answers].each_value do |a|
      answer = Answer.new
      answer.content = a[:content]
      @answers << answer
    end
    render :partial => 'preview'
  end
  
  def destroy
    project_id = @survey.project.identifier
    @survey.destroy
    redirect_to :action => 'index', :project_id => project_id
  end
  
  private
  
  def find_survey_and_project
    if (params[:id])
      @survey = Survey.find(params[:id])
    end
    
    # @project variable must be set before calling the authorize filter    
    @project = Project.find(params[:project_id] || @survey.project_id)    
  end
  
  def respond_to(answer_id)
    if a = @survey.answers.find(answer_id)
      r = Response.new()
      r.user = User.current
      a.responses << r
    end
  end
  
  def add_answers(answers)
    return unless answers.is_a?(Hash) && @survey
    answers.each_value do |a|
      answer = Answer.new
      answer.content = a[:content]
      @survey.answers << answer
    end
  end

end
