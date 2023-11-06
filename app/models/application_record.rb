class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  def user_active?
    if current_user.is_deleted == true
      reset_session
      redirect_to root_path, notice: "退会されているため操作できません。"
    end
  end
end
