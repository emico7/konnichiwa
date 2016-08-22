module AnswersHelper
  def user_is_authorized_for_answer?(answer)
    current_user && (current_user == answer.user || current_user.admin?)
  end
end
