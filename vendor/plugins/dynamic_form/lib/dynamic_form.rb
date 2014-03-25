require 'action_view/helpers/dynamic_form'

# hack to get this to run 
  # !!!
  
def debug_rjs=(val)
      
end
  
class ActionView::Base
  include DynamicForm
    
end
