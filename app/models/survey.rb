class Survey < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  has_many :answers, :dependent => :destroy, :order => 'id asc'
  has_many :response_comments
  has_many :responses, :through => :answers
  has_many :responders, :class_name => 'User', :finder_sql => proc {
"select users.* " +
"from users " +
"left join responses on responses.user_id = users.id " +
"left join answers on responses.answer_id = answers.id " +
"left join surveys on answers.survey_id = surveys.id " +
"left join response_comments on response_comments.user_id = users.id " +
"where surveys.id = #{self.id} " +
"group by users.id" }
  
  # alternative to responders:
  #User.find(Response.count(:conditions => {:answer_id => Survey.all.first.answer_ids}, :group => :user_id).keys)

  def response_from?(user)
    not self.responders.find(user.id).nil?
  end
  
  #def total_responses
  #  responders.count

    #total = 0
    #if responses_by_user = Response.count(:conditions => {:answer_id => answer_ids}, :group => :user_id)
    #  total += responses_by_user.count
    #end
    # add comments
    #if responses_by_user = ResponseComments.find_by_survey_id(id)
    #  total += responses_by_user.count
    #end
    #total
  #end
  
  def remove_response_by_user(user)
    Response.find_all_by_user_id_and_answer_id(user.id, answer_ids).each do |r|
      r.destroy
    end
    ResponseComment.find_all_by_user_id_and_survey_id(user.id, id).each do |r|
      r.destroy
    end
  end
  
  def is_valid?
    valid_until >= Time.now.to_date
  end
  
end
