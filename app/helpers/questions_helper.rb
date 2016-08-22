module QuestionsHelper
   def user_is_authorized_for_question?(question)
        current_user && (current_user == question.user || current_user.admin?)
   end
 end
