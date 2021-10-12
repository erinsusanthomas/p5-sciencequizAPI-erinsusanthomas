module UserAuthentication 

  # For authentication
  STATUSES = [['Administrator', :admin],['Leader', :leader],['Coach', :coach]].freeze

  def role?(authorized_role)
    return false if status.nil?
    status.downcase.to_sym == authorized_role
  end
  
  # login by username
  def User.authenticate(username, password)
    find_by_username(username).try(:authenticate, password)
  end 

end