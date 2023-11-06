class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def active_for_authentication?
    super && current_user.is_deleted == true
    redirect_to new_user_registration_path
  end
end
