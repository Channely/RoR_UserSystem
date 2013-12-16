module AdministratorHelper

  def admin?
    current_user && current_user[:id] == 1
  end

end